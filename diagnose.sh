#!/bin/bash

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔍 PIN-PAN Protocol - Diagnóstico${NC}\n"

# Verificar Go
echo -e "${YELLOW}1️⃣  Verificando Go...${NC}"
if command -v go &> /dev/null; then
    GO_VERSION=$(go version)
    echo -e "${GREEN}✅ Go instalado: $GO_VERSION${NC}"
else
    echo -e "${RED}❌ Go não encontrado${NC}"
fi
echo ""

# Verificar Python
echo -e "${YELLOW}2️⃣  Verificando Python...${NC}"
if command -v python3 &> /dev/null; then
    PY_VERSION=$(python3 --version)
    echo -e "${GREEN}✅ Python instalado: $PY_VERSION${NC}"
else
    echo -e "${RED}❌ Python não encontrado${NC}"
fi
echo ""

# Verificar estrutura de arquivos
echo -e "${YELLOW}3️⃣  Verificando arquivos...${NC}"

FILES=("index.html" "styles.css" "container.js" "calculator.go" "test-api.sh" "start.sh")
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        SIZE=$(ls -lh "$file" | awk '{print $5}')
        echo -e "${GREEN}✅ $file ($SIZE)${NC}"
    else
        echo -e "${RED}❌ $file NÃO ENCONTRADO${NC}"
    fi
done
echo ""

# Verificar pasta assets
echo -e "${YELLOW}4️⃣  Verificando pasta assets...${NC}"
if [ -d "assets" ]; then
    echo -e "${GREEN}✅ Pasta assets existe${NC}"
    
    if [ -f "assets/background.mp4" ]; then
        MP4_SIZE=$(ls -lh "assets/background.mp4" | awk '{print $5}')
        echo -e "${GREEN}  ✅ background.mp4 ($MP4_SIZE)${NC}"
    else
        echo -e "${RED}  ❌ background.mp4 NÃO ENCONTRADO${NC}"
    fi
    
    if [ -f "assets/theme.mp3" ]; then
        MP3_SIZE=$(ls -lh "assets/theme.mp3" | awk '{print $5}')
        echo -e "${GREEN}  ✅ theme.mp3 ($MP3_SIZE)${NC}"
    else
        echo -e "${RED}  ❌ theme.mp3 NÃO ENCONTRADO${NC}"
    fi
else
    echo -e "${RED}❌ Pasta assets NÃO EXISTE${NC}"
    echo -e "${YELLOW}   Crie com: mkdir assets${NC}"
fi
echo ""

# Verificar portas disponíveis
echo -e "${YELLOW}5️⃣  Verificando portas...${NC}"
if netstat -tuln 2>/dev/null | grep -q ":8080 "; then
    echo -e "${YELLOW}⚠️  Porta 8080 já está em uso${NC}"
else
    echo -e "${GREEN}✅ Porta 8080 disponível${NC}"
fi

if netstat -tuln 2>/dev/null | grep -q ":3000 "; then
    echo -e "${YELLOW}⚠️  Porta 3000 já está em uso${NC}"
else
    echo -e "${GREEN}✅ Porta 3000 disponível${NC}"
fi
echo ""

# Compilar Go
echo -e "${YELLOW}6️⃣  Testando compilação Go...${NC}"
if go build -o /tmp/pin-pan-test calculator.go 2>/dev/null; then
    echo -e "${GREEN}✅ Go compila corretamente${NC}"
    rm -f /tmp/pin-pan-test
else
    echo -e "${RED}❌ Erro ao compilar Go${NC}"
fi
echo ""

echo -e "${BLUE}═══════════════════════════════════${NC}"
echo -e "${GREEN}Para rodar tudo de uma vez:${NC}"
echo -e "${YELLOW}  chmod +x start.sh${NC}"
echo -e "${YELLOW}  ./start.sh${NC}"
echo ""
echo -e "${GREEN}Ou em terminais separados:${NC}"
echo -e "${YELLOW}  Terminal 1: go run calculator.go${NC}"
echo -e "${YELLOW}  Terminal 2: python3 -m http.server 3000${NC}"
echo -e "${YELLOW}  Terminal 3: ./test-api.sh${NC}"
echo -e "${BLUE}═══════════════════════════════════${NC}"