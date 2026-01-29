#!/bin/bash

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 PIN-PAN Protocol - Iniciando...${NC}\n"

# Verificar se arquivos existem
if [ ! -f "calculator.go" ]; then
    echo -e "${YELLOW}❌ calculator.go não encontrado!${NC}"
    exit 1
fi

if [ ! -f "index.html" ]; then
    echo -e "${YELLOW}❌ index.html não encontrado!${NC}"
    exit 1
fi

# Iniciar Go backend em background
echo -e "${YELLOW}🔧 Iniciando backend Go...${NC}"
go run calculator.go &
GO_PID=$!
sleep 2

# Iniciar servidor HTTP em background
echo -e "${YELLOW}📡 Iniciando servidor HTTP...${NC}"
python3 -m http.server 3000 &
HTTP_PID=$!
sleep 2

# Abrir navegador
echo -e "${YELLOW}🌐 Abrindo navegador...${NC}"
xdg-open "http://localhost:3000" 2>/dev/null || open "http://localhost:3000" 2>/dev/null || echo "Abra: http://localhost:3000"

echo -e "\n${GREEN}✅ Tudo iniciado!${NC}\n"
echo -e "${BLUE}Acessar em: http://localhost:3000${NC}"
echo -e "${BLUE}API em: http://localhost:8080${NC}\n"

echo -e "${YELLOW}Pressione Ctrl+C para parar${NC}\n"

# Manter script rodando
wait