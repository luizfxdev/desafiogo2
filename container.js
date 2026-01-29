// container.js - Gerenciador de API e eventos do frontend

class PINPANController {
    constructor() {
        this.apiUrl = 'http://localhost:8080/calculate';
        this.apiBase = 'http://localhost:8080';
        this.initElements();
        this.initAudio();
        this.bindEvents();
        this.checkAPIHealth();
    }

    // Verifica saúde da API
    checkAPIHealth() {
        fetch(this.apiBase, { method: 'GET' })
            .then(res => res.json())
            .then(data => {
                console.log('✅ API conectada:', data);
            })
            .catch(err => {
                console.warn('⚠️ API não disponível. Inicie com: go run calculator.go');
            });
    }

    // Inicializa referências dos elementos DOM
    initElements() {
        this.operationSelect = document.getElementById('operationSelect');
        this.calculateBtn = document.getElementById('calculateBtn');
        this.resetBtn = document.getElementById('resetBtn');
        this.resultSection = document.getElementById('resultSection');
        this.outputResult = document.getElementById('outputResult');
        this.detailedCalculation = document.getElementById('detailedCalculation');
        this.audioToggle = document.getElementById('audioToggle');
        this.themeAudio = document.getElementById('themeAudio');
    }

    // Inicializa controle de áudio
    initAudio() {
        this.isAudioPlaying = false;
        this.themeAudio.volume = 0.3;
        this.audioToggle.setAttribute('aria-pressed', 'false');
    }

    // Vincula eventos aos elementos
    bindEvents() {
        this.calculateBtn.addEventListener('click', () => this.handleCalculate());
        this.resetBtn.addEventListener('click', () => this.handleReset());
        this.audioToggle.addEventListener('click', () => this.toggleAudio());
        this.operationSelect.addEventListener('change', () => this.clearResult());
    }

    // Gerencia cálculo - conecta com API Go
    async handleCalculate() {
        const operation = this.operationSelect.value;

        if (!operation) {
            this.showError('Selecione uma operação antes de calcular');
            return;
        }

        this.calculateBtn.disabled = true;
        this.calculateBtn.textContent = 'CALCULANDO...';

        try {
            const response = await fetch(this.apiUrl, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ operation: parseInt(operation) }),
            });

            if (!response.ok) {
                throw new Error(`Erro HTTP! status: ${response.status}`);
            }

            const data = await response.json();
            this.displayResult(data);
        } catch (error) {
            console.error('Erro detalhado:', error);
            this.showError(
                `Erro ao conectar com a API.\n\n` +
                `Certifique-se de que o servidor Go está rodando:\n` +
                `go run calculator.go\n\n` +
                `Erro: ${error.message}`
            );
        } finally {
            this.calculateBtn.disabled = false;
            this.calculateBtn.innerHTML = '<span class="btn-content">CALCULAR</span>';
        }
    }

    // Exibe resultado com animação
    displayResult(data) {
        this.outputResult.textContent = data.output;
        this.detailedCalculation.innerHTML = this.buildDetailedSteps(data);
        this.resultSection.style.display = 'block';
        
        // Aguarda a animação e depois faz scroll
        setTimeout(() => {
            this.resultSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }, 100);
    }

    // Constrói passos detalhados do cálculo
    buildDetailedSteps(data) {
        const operationType = data.operation === 1 
            ? 'Divisíveis por 3' 
            : 'Múltiplos (PIN-PAN)';

        let html = `
            <div class="step">
                <div class="step-title">📋 Configuração</div>
                <div class="step-content">
                    Operação: <strong>${operationType}</strong><br>
                    Intervalo: <strong>1 a 100</strong>
                </div>
            </div>
        `;

        if (data.operation === 1) {
            html += `
                <div class="step">
                    <div class="step-title">🔍 Lógica de Verificação</div>
                    <div class="step-content">
                        Para cada número n de 1 a 100:<br>
                        <strong>if (n % 3 === 0)</strong> → incluir no resultado
                    </div>
                </div>
                <div class="step">
                    <div class="step-title">✅ Números Encontrados</div>
                    <div class="step-content">
                        Total: <strong>${data.count}</strong> números divisíveis por 3
                    </div>
                </div>
            `;
        } else if (data.operation === 2) {
            html += `
                <div class="step">
                    <div class="step-title">🔍 Lógica de Verificação</div>
                    <div class="step-content">
                        Para cada número n de 1 a 100:<br>
                        <strong>if (n % 3 === 0 && n % 5 === 0)</strong> → "PINPAN"<br>
                        <strong>else if (n % 3 === 0)</strong> → "PIN"<br>
                        <strong>else if (n % 5 === 0)</strong> → "PAN"<br>
                        <strong>else</strong> → número original
                    </div>
                </div>
                <div class="step">
                    <div class="step-title">📊 Estatísticas</div>
                    <div class="step-content">
                        Múltiplos de 3: <strong>${data.stats.pin}</strong><br>
                        Múltiplos de 5: <strong>${data.stats.pan}</strong><br>
                        Múltiplos de 3 e 5: <strong>${data.stats.pinpan}</strong><br>
                        Números normais: <strong>${data.stats.normal}</strong>
                    </div>
                </div>
            `;
        }

        return html;
    }

    // Reseta o formulário
    handleReset() {
        this.operationSelect.value = '';
        this.clearResult();
        this.operationSelect.focus();
    }

    // Limpa resultado anterior
    clearResult() {
        this.resultSection.style.display = 'none';
        this.outputResult.textContent = '';
        this.detailedCalculation.innerHTML = '';
    }

    // Controla áudio
    toggleAudio() {
        if (this.isAudioPlaying) {
            this.themeAudio.pause();
            this.audioToggle.querySelector('.audio-icon').textContent = '🎵';
            this.audioToggle.setAttribute('aria-pressed', 'false');
        } else {
            this.themeAudio.play().catch(err => {
                console.warn('Erro ao reproduzir áudio:', err);
                this.showError(
                    'Não foi possível reproduzir o áudio.\n\n' +
                    'Verifique se:\n' +
                    '1. O arquivo theme.mp3 está em assets/\n' +
                    '2. O caminho está correto no HTML'
                );
            });
            this.audioToggle.querySelector('.audio-icon').textContent = '⏸️';
            this.audioToggle.setAttribute('aria-pressed', 'true');
        }
        this.isAudioPlaying = !this.isAudioPlaying;
    }

    // Exibe mensagem de erro
    showError(message) {
        alert(`⚠️ ${message}`);
    }
}

// Inicializa quando DOM está pronto
document.addEventListener('DOMContentLoaded', () => {
    new PINPANController();
});