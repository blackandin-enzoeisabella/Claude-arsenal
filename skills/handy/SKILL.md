---
name: handy
description: Especialista no Handy (cjpais), app desktop gratuito e open source de speech-to-text 100% offline (Whisper e Parakeet, VAD Silero) que transcreve ao apertar um atalho e cola o texto no app ativo. Use para instalar, escolher modelo (velocidade x precisão, português), configurar atalhos, controlar por CLI (--toggle-transcription) e integrar ditado em fluxos de trabalho. Triggers - handy, ditado por voz, speech to text, transcrição offline, whisper local, falar em vez de digitar, superwhisper alternativo.
---

# Handy

Repo: https://github.com/cjpais/Handy · open source · Windows, macOS, Linux · site handy.computer

Aperte o atalho → fale → solte → o texto aparece no app em foco. Áudio nunca sai do computador.

## Instalação
- Download em Releases ou no site.
- macOS: `brew install --cask handy` · Windows: `winget install cjpais.Handy` (pacotes de terceiros).
- Debian/Ubuntu: `sudo apt install ./Handy_*.deb` (não use `dpkg -i`; se usou: `sudo apt --fix-broken install`).
Depois: abrir, conceder permissões de **microfone** e **acessibilidade**, configurar atalho.

## Escolha de modelo (opinião)
- **Parakeet V3**: otimizado para CPU, detecção automática de idioma — padrão para notebook sem GPU.
- **Whisper Turbo/Large**: melhor precisão em português e jargão técnico se houver GPU.
- **Whisper Small/Medium**: máquinas fracas.
Use o **dicionário** para nomes próprios e termos técnicos recorrentes (nomes de projetos, libs).

## Controle por CLI (automação)
```bash
handy --toggle-transcription    # liga/desliga gravação na instância aberta
handy --toggle-post-process     # gravação com pós-processamento
handy --cancel
handy --start-hidden            # iniciar sem janela (bom para autostart)
```
Mapeie esses comandos em atalhos do sistema, Raycast (há integração) ou num pedal/stream deck.

## Fluxo com o Claude
Ditar prompts longos ao Claude Code é 3–4× mais rápido que digitar. Dica: fale o pedido completo (contexto → objetivo → critério de pronto) e revise antes de enviar.

## Depuração
Modo debug: `Cmd+Shift+D` (macOS) / `Ctrl+Shift+D` (Win/Linux). No Linux/Wayland, colar automático pode exigir ferramentas extras (ver BUILD.md/issues).

## Verificação
Abrir um editor de texto, segurar o atalho, dizer uma frase, soltar → frase colada corretamente.
