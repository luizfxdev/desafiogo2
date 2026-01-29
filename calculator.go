package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
)

// RequestPayload estrutura a requisição recebida do frontend
type RequestPayload struct {
	Operation int `json:"operation"`
}

// ResponsePayload estrutura a resposta enviada ao frontend
type ResponsePayload struct {
	Operation int            `json:"operation"`
	Output    string         `json:"output"`
	Count     int            `json:"count,omitempty"`
	Stats     map[string]int `json:"stats,omitempty"`
}

// calculateDivisibles retorna todos os números divisíveis por 3 entre 1 e 100
func calculateDivisibles() []int {
	var result []int
	for i := 1; i <= 100; i++ {
		if i%3 == 0 {
			result = append(result, i)
		}
	}
	return result
}

// calculateMultiples implementa a lógica PIN-PAN
// Múltiplos de 3: PIN, Múltiplos de 5: PAN, Múltiplos de ambos: PINPAN
func calculateMultiples() ([]string, map[string]int) {
	var result []string
	stats := map[string]int{
		"pin":    0,
		"pan":    0,
		"pinpan": 0,
		"normal": 0,
	}

	for i := 1; i <= 100; i++ {
		if i%3 == 0 && i%5 == 0 {
			result = append(result, "PINPAN")
			stats["pinpan"]++
		} else if i%3 == 0 {
			result = append(result, "PIN")
			stats["pin"]++
		} else if i%5 == 0 {
			result = append(result, "PAN")
			stats["pan"]++
		} else {
			result = append(result, fmt.Sprintf("%d", i))
			stats["normal"]++
		}
	}

	return result, stats
}

// formatDivisiblesOutput converte slice de inteiros para string formatada
func formatDivisiblesOutput(numbers []int) string {
	var output []string
	for _, num := range numbers {
		output = append(output, fmt.Sprintf("%d", num))
	}
	return strings.Join(output, " ")
}

// formatMultiplesOutput converte slice de strings para saída formatada
func formatMultiplesOutput(values []string) string {
	return strings.Join(values, " ")
}

// handleCalculate processa requisições POST da API
func handleCalculate(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type")

	if r.Method == "OPTIONS" {
		w.WriteHeader(http.StatusOK)
		return
	}

	var payload RequestPayload
	if err := json.NewDecoder(r.Body).Decode(&payload); err != nil {
		http.Error(w, "Invalid JSON", http.StatusBadRequest)
		return
	}

	var response ResponsePayload
	response.Operation = payload.Operation

	switch payload.Operation {
	case 1:
		// Operação 1: Divisíveis por 3
		divisibles := calculateDivisibles()
		response.Output = formatDivisiblesOutput(divisibles)
		response.Count = len(divisibles)

	case 2:
		// Operação 2: Múltiplos (PIN-PAN)
		multiples, stats := calculateMultiples()
		response.Output = formatMultiplesOutput(multiples)
		response.Stats = stats

	default:
		http.Error(w, "Invalid operation", http.StatusBadRequest)
		return
	}

	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(response)
}

// handleRoot fornece endpoint de health check
func handleRoot(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]string{
		"status":  "PIN-PAN Protocol Active",
		"version": "1.0.0",
	})
}

// main inicializa servidor HTTP e define rotas
func main() {
	http.HandleFunc("/", handleRoot)
	http.HandleFunc("/calculate", handleCalculate)

	port := ":8080"
	fmt.Printf("🔒 PIN-PAN Protocol iniciado em http://localhost%s\n", port)
	fmt.Println("📡 Aguardando conexões...")

	if err := http.ListenAndServe(port, nil); err != nil {
		log.Fatalf("Erro ao iniciar servidor: %v", err)
	}
}
