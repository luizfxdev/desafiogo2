# PIN-PAN Protocol 🧠 | Zero Echo's Algorithm Decoder

Decodifique o Protocolo PIN-PAN nas ruas de Neo-Shibuya. Uma aplicação full-stack que combina Go (backend) com JavaScript (frontend) para revelar padrões matemáticos ocultos.

## 📋 Estrutura do Projeto

```
├── calculator.go          # Backend Go - API REST
├── container.js           # Frontend JavaScript - Gerenciador de API
├── index.html            # HTML Semântico
├── styles.css            # CSS Responsivo com Animações
├── assets/
│   ├── background.mp4    # Video 4K (3840x2160)
│   └── theme.mp3         # Música tema
└── README.md            # Este arquivo
```

## 🚀 Como Executar

### Pré-requisitos
- Go 1.16+ instalado
- Navegador moderno (Chrome, Firefox, Safari, Edge)
- Video background.mp4 e áudio theme.mp3 na pasta `assets/`

### 1️⃣ Clonar/Baixar os Arquivos

Organize os arquivos na seguinte estrutura:

```
seu-projeto/
├── calculator.go
├── container.js
├── index.html
├── styles.css
└── assets/
    ├── background.mp4
    └── theme.mp3
```

### 2️⃣ Compilar e Executar o Backend (Go)

```bash
# Navegar até o diretório do projeto
cd seu-projeto

# Compilar o Go
go build -o pin-pan-server calculator.go

# Executar o servidor
./pin-pan-server

# Ou executar direto:
go run calculator.go
```

Você verá:
```
🔒 PIN-PAN Protocol iniciado em http://localhost:8080
📡 Aguardando conexões...
```

### 3️⃣ Servir o Frontend

Abra um segundo terminal:

```bash
# Usando Python 3 (mais simples)
python -m http.server 3000

# Ou usando Python 2
python -m SimpleHTTPServer 3000

# Ou usando Node.js (http-server)
npx http-server -p 3000

# Ou usando PHP
php -S localhost:3000
```

### 4️⃣ Acessar no Navegador

Abra seu navegador e acesse:
```
http://localhost:3000
```

## 🎮 Como Usar

1. **Selecione uma operação** no dropdown:
   - `1 - Divisíveis por 3`: Exibe números divisíveis por 3 entre 1-100
   - `2 - Múltiplos (PIN-PAN)`: Exibe padrão PIN-PAN

2. **Clique em CALCULAR** para processar

3. **Visualize o resultado** com cálculo detalhado

4. **Clique em RETORNAR** para limpar e começar novamente

5. **Controle a música** com o botão 🎵 no canto superior direito

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

## 📱 Responsividade

- ✅ Desktop (1920px+)
- ✅ Tablets (768px - 1024px)
- ✅ Mobile (320px - 480px)

Botões se reorganizam em coluna em telas menores.

## 🎨 Paleta de Cores

- **Ouro/Amarelo**: `#FFD700` (principal)
- **Preto**: `#000000` (fundo)
- **Cinza**: `#78909C` (secundário)
- **Gradientes**: Preto + Ouro + Laranja

## 🔐 Funcionalidades PIN-PAN

### Operação 1: Divisíveis por 3
```
Lógica: if (n % 3 == 0) → incluir
Resultado: 3 6 9 12 15 18 ... 99
```

### Operação 2: Múltiplos (PIN-PAN)
```
Lógica:
- n % 3 == 0 && n % 5 == 0 → PINPAN
- n % 3 == 0 → PIN
- n % 5 == 0 → PAN
- else → número
```

## 🛠️ Troubleshooting

### Erro: "Não consegue conectar com a API"
- Certifique-se de que o servidor Go está rodando (`go run calculator.go`)
- Verifique se está usando `http://localhost:8080`
- Checa se o CORS está habilitado

### Vídeo não carrega
- Adicione o arquivo `background.mp4` em `assets/`
- Verifique o caminho no HTML

### Áudio não funciona
- Adicione o arquivo `theme.mp3` em `assets/`
- Alguns navegadores bloqueiam autoplay (click no botão manualmente)

### Responsividade quebrada
- Limpe cache do navegador (Ctrl+Shift+Delete)
- Teste em modo incógnito
- Verifique viewport no HTML

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

## 🎯 Performance

- Backend: ~1ms por requisição
- Frontend: Resposta imediata
- Video: Otimizado para 4K
- Arquivo CSS: ~15KB (minificado)
- Arquivo JS: ~5KB (minificado)

## 📝 Notas Importantes

1. **CORS**: Frontend e Backend devem estar em portas diferentes ou CORS deve ser configurado
2. **Segurança**: Para produção, adicione autenticação e validação robusta
3. **Escalabilidade**: Para muitos usuários, considere usar database
4. **Mobile**: Testar em dispositivos reais, não apenas DevTools

## 👨‍💻 Desenvolvido para

- Full-stack developers
- Programadores Go/JavaScript
- Desafio de algoritmo PIN-PAN
- Tema cyberpunk Neo-Shibuya

## 📞 Suporte

Se encontrar problemas:
1. Verifique se ambos servidores (Go + HTTP) estão rodando
2. Confirme os caminhos dos assets (video e áudio)
3. Teste a API direto: `curl -X POST http://localhost:8080/calculate -H "Content-Type: application/json" -d '{"operation": 1}'`

---

**Missão Aceita?** Decodifique o protocolo. 🧠⚡
