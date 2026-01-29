#!/bin/bash

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🧠 PIN-PAN Protocol - Teste de API${NC}\n"

API_URL="http://localhost:8080"
FRONTEND_URL="http://localhost:3000"
MAX_RETRIES=10
RETRY_DELAY=1

# Função para testar API
test_api() {
    curl -s -o /dev/null -w "%{http_code}" "$API_URL"
}

# Aguardar API ficar pronta
echo -e "${YELLOW}⏳ Aguardando API ficar pronta...${NC}"
ATTEMPT=1
while [ $ATTEMPT -le $MAX_RETRIES ]; do
    HTTP_CODE=$(test_api)
    if [ "$HTTP_CODE" = "200" ]; then
        echo -e "${GREEN}✅ API pronta!${NC}\n"
        break
    fi
    echo -e "${YELLOW}  Tentativa $ATTEMPT/$MAX_RETRIES... (aguardando $RETRY_DELAY seg)${NC}"
    sleep $RETRY_DELAY
    ATTEMPT=$((ATTEMPT + 1))
done

# Se API não respondeu
if [ "$HTTP_CODE" != "200" ]; then
    echo -e "${RED}❌ API não respondeu após $MAX_RETRIES tentativas${NC}"
    echo -e "${YELLOW}Certifique-se de que rodou em outro terminal:${NC}"
    echo -e "${YELLOW}  go run calculator.go${NC}"
    exit 1
fi

# Abrir navegador
echo -e "${YELLOW}🌐 Abrindo navegador...${NC}"
xdg-open "$FRONTEND_URL" 2>/dev/null || open "$FRONTEND_URL" 2>/dev/null || echo "Abra manualmente: $FRONTEND_URL"
echo ""

# Fazer testes
echo -e "${YELLOW}1️⃣  Health Check${NC}"
curl -s "$API_URL" | python3 -m json.tool 2>/dev/null || curl -s "$API_URL"
echo -e "\n"

echo -e "${YELLOW}2️⃣  Teste Operação 1 (Divisíveis por 3)${NC}"
curl -s -X POST "$API_URL/calculate" \
  -H "Content-Type: application/json" \
  -d '{"operation": 1}' | python3 -m json.tool 2>/dev/null || curl -s -X POST "$API_URL/calculate" -H "Content-Type: application/json" -d '{"operation": 1}'
echo -e "\n"

echo -e "${YELLOW}3️⃣  Teste Operação 2 (Múltiplos PIN-PAN)${NC}"
curl -s -X POST "$API_URL/calculate" \
  -H "Content-Type: application/json" \
  -d '{"operation": 2}' | python3 -m json.tool 2>/dev/null || curl -s -X POST "$API_URL/calculate" -H "Content-Type: application/json" -d '{"operation": 2}'
echo -e "\n"

echo -e "${GREEN}✅ Testes concluídos!${NC}"
echo -e "${GREEN}✅ Frontend: $FRONTEND_URL${NC}"