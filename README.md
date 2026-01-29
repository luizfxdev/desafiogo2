# PIN-PAN Protocol  | Zero Echo's Algorithm Decoder 🧠

[![Go](https://img.shields.io/badge/Go-1.21%2B-00ADD8?style=flat-square&logo=go)](https://golang.org)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES6%2B-F7DF1E?style=flat-square&logo=javascript)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![HTML5](https://img.shields.io/badge/HTML5-Semantic-E34C26?style=flat-square&logo=html5)](https://html.spec.whatwg.org)
[![CSS3](https://img.shields.io/badge/CSS3-Responsive-1572B6?style=flat-square&logo=css3)](https://www.w3.org/Style/CSS/)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)

Decodifique o **Protocolo PIN-PAN** nas ruas de Neo-Shibuya. Uma aplicação full-stack que combina **Go** (backend) com **JavaScript** (frontend) para revelar padrões matemáticos ocultos através de operações de módulo e loops.

---

## 📖 Descrição do Desafio

Nas ruas escuras de **Neo-Shibuya**, onde neon corta a noite e dados fluem como sangue digital, uma hacker lendária conhecida apenas como **"Zero Echo"** domina os algoritmos. Com seus óculos dourados refletindo circuitos infinitos, ela controla o fluxo de informações através de padrões matemáticos ocultos.

Você foi recrutado para **decodificar o Protocolo PIN-PAN**, um algoritmo que revela segredos escondidos nos números através de operações com o operador `%` (módulo) e loops `for`.

### 🎯 Objetivos

1. **Operação 1 - Divisíveis**: Exibir todos os números entre 1 e 100 que são divisíveis por 3
2. **Operação 2 - Múltiplos (PIN-PAN)**: Para cada número de 1 a 100:
   - Se múltiplo de 3 → exibir "PIN"
   - Se múltiplo de 5 → exibir "PAN"
   - Se múltiplo de ambos → exibir "PINPAN"
   - Caso contrário → exibir o número original

---

## 🔄 Rotina do Projeto

### Frontend → Backend (Fluxo de Dados)

```
┌─────────────────────────────────────────────────────────────┐
│ 1. USUÁRIO INTERAGE COM INTERFACE                          │
│    ├─ Seleciona operação (1 ou 2) no dropdown              │
│    ├─ Clica botão CALCULAR                                 │
│    └─ JavaScript dispara evento click                      │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│ 2. CONTAINER.JS PROCESSA REQUISIÇÃO                        │
│    ├─ Valida seleção de operação                           │
│    ├─ Cria JSON: { operation: 1 ou 2 }                     │
│    └─ Envia POST para http://localhost:8080/calculate      │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│ 3. CALCULATOR.GO PROCESSA LÓGICA                           │
│    ├─ Recebe JSON com número da operação                   │
│    ├─ Se operação == 1:                                    │
│    │   └─ Loop for (i=1 até 100): if i%3==0 → inclui      │
│    ├─ Se operação == 2:                                    │
│    │   └─ Loop for (i=1 até 100): verifica %3 e %5        │
│    └─ Retorna JSON com resultado e estatísticas            │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│ 4. CONTAINER.JS RENDERIZA RESULTADO                        │
│    ├─ Recebe JSON da API                                   │
│    ├─ Exibe "Saída Esperada" no campo resultado            │
│    ├─ Monta "Cálculo Detalhado" com passos                │
│    └─ Anima resultado com scroll suave                     │
└────────────────────┬────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────────┐
│ 5. USUÁRIO VÊ RESULTADO NA TELA                            │
│    ├─ Resultado exibido com formatação                     │
│    ├─ Detalhamento do cálculo visível                      │
│    └─ Pode clicar RETORNAR para nova operação              │
└─────────────────────────────────────────────────────────────┘
```

### Tecnologias Utilizadas

| Camada | Tecnologia | Função |
|--------|-----------|--------|
| **Backend** | Go 1.21+ | API REST, lógica de cálculo, servidor HTTP |
| **Frontend** | JavaScript ES6+ | Controle de eventos, requisições AJAX, DOM manipulation |
| **Markup** | HTML5 Semântico | Estrutura da página, acessibilidade |
| **Styling** | CSS3 | Layout responsivo, animações, tema cyberpunk |
| **Áudio/Vídeo** | HTML5 Media | Background 4K, tema sonora interativa |

---

## 📋 Estrutura do Projeto

```
├── calculator.go          # Backend Go - API REST
├── container.js           # Frontend JavaScript - Gerenciador de API
├── index.html            # HTML Semântico
├── styles.css            # CSS Responsivo com Animações
├── start.sh              # Script para rodar tudo junto
├── test-api.sh           # Script para testar a API
├── diagnose.sh           # Script de diagnóstico
├── assets/
│   ├── background.mp4    # Video 4K (3840x2160)
│   └── theme.mp3         # Música tema
└── README.md            # Este arquivo
```

---

## 🚀 Como Executar

### Pré-requisitos
- Go 1.16+ instalado
- Python 3 instalado
- Navegador moderno (Chrome, Firefox, Safari, Edge)
- Arquivos: `background.mp4` e `theme.mp3` em `assets/` (opcional)

### 🌟 Forma Mais Fácil (Recomendado)

```bash
cd seu-projeto
chmod +x start.sh
./start.sh
```

Isso roda **tudo automaticamente** em um só comando! 🚀

### Alternativa: 3 Terminais Separados

**Terminal 1 - Backend:**
```bash
cd seu-projeto
go run calculator.go
```

**Terminal 2 - Frontend:**
```bash
cd seu-projeto
python3 -m http.server 3000
```

**Terminal 3 - Testar (Opcional):**
```bash
cd seu-projeto
chmod +x test-api.sh
./test-api.sh
```

### Acessar no Navegador
```
http://localhost:3000
```

---

## 🎮 Como Usar

1. **Selecione uma operação** no dropdown
2. **Clique em CALCULAR** para processar
3. **Visualize o resultado** com cálculo detalhado
4. **Clique em RETORNAR** para nova operação
5. **Controle a música** com o botão 🎵

---

## 🔧 Arquitetura

### Backend (calculator.go)
- **GET `/`**: Health check
- **POST `/calculate`**: Processa operação
  - Body: `{ "operation": 1 ou 2 }`
  - Response: JSON com resultado e estatísticas

### Frontend (container.js)
- **PINPANController**: Gerencia API e eventos
- Conexão com `http://localhost:8080/calculate`
- Renderização dinâmica de resultados

### Estilos (styles.css)
- Responsivo (mobile-first)
- Animações suaves
- Tema cyberpunk (amarelo/preto)
- Accessibility completa

---

## 📱 Responsividade

- ✅ Desktop (1920px+)
- ✅ Tablets (768px - 1024px)
- ✅ Mobile (320px - 480px)

---

## 🎨 Paleta de Cores

- **Ouro/Amarelo**: `#FFD700` (principal)
- **Preto**: `#000000` (fundo)
- **Cinza**: `#78909C` (secundário)
- **Gradientes**: Preto + Ouro + Laranja

---

## 📚 Dependências

### Backend (Go)
- `net/http` - Servidor HTTP padrão
- `encoding/json` - Serialização JSON
- `strings` - Manipulação de strings

### Frontend
- HTML5
- CSS3
- JavaScript ES6+
- Nenhuma biblioteca externa requerida

---

## 🎯 Performance

- Backend: ~1ms por requisição
- Frontend: Resposta imediata
- Video: Otimizado para 4K
- Arquivo CSS: ~15KB
- Arquivo JS: ~7KB

---

## 👨‍💻 Desenvolvido para

- Full-stack developers
- Programadores Go/JavaScript
- Desafio de algoritmo PIN-PAN
- Tema cyberpunk Neo-Shibuya

---


## 👨‍💻 Autor

**Luiz Felipe de Oliveira**

Desenvolvedor Full Stack apaixonado por criar soluções elegantes e eficientes.

- 🌐 **Portfólio:** [luizfxdev.com.br](https://luizfxdev.com.br)
- 💼 **LinkedIn:** [in/luizfxdev](https://www.linkedin.com/in/luizfxdev)
- 🐙 **GitHub:** [@luizfxdev](https://github.com/luizfxdev)

---


<div align="center">

**Desenvolvido com 💙 usando Go, JavaScript e muita criatividade**



</div>

