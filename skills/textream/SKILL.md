---
name: textream
description: Especialista no Textream, teleprompter gratuito open source para macOS/iPhone/iPad que destaca o roteiro palavra por palavra conforme você fala (overlay no notch / Dynamic Island). Use para preparar roteiros de vídeo, lives, podcasts, apresentações e entrevistas para leitura no teleprompter, configurar modos (word tracking, classic, voice-activated), Remote Connection, Director Mode ou importar notas de PowerPoint. Triggers - textream, teleprompter, prompter, roteiro para gravar, ler roteiro olhando para câmera.
---

# Textream

Repo: https://github.com/f/textream · MIT · macOS 15+ (Apple Silicon/Intel), iOS/iPadOS 26

## Instalação
```bash
brew install textream
```
Ou App Store (universal Mac/iPhone/iPad) ou `.dmg` em GitHub Releases.

## Onde o Claude ajuda de verdade
O app é GUI; o valor do agente está em **escrever o roteiro no formato certo** e configurar:

### Roteiro otimizado para teleprompter
- Frases curtas (≤ 15 palavras), uma ideia por linha, linguagem falada.
- Marcadores de respiração/pausa como quebra de parágrafo (não use símbolos que a voz não pronuncia — o word tracking compara com a fala).
- Números por extenso quando forem lidos ("dois mil e vinte e seis"), siglas como se pronunciam.
- Divida em **páginas** por bloco/slide (o app navega por páginas e avança automático).
- Salve como `.textream` para reutilizar; ou entregue `.txt` para colar.

### Importar de apresentação
Arraste um `.pptx`: as **notas do apresentador** viram páginas. Keynote/Google Slides → exportar para PowerPoint antes. Combina com a skill `presenton` (gera o deck + notas).

## Modos
- **Word Tracking**: destaca cada palavra conforme fala (reconhecimento de voz do macOS; escolha o idioma, ex. pt-BR).
- **Classic**: rolagem constante (0,5–8 palavras/s).
- **Voice-Activated**: rola quando você fala.
Overlays: preso ao notch, janela flutuante (segue cursor), tela cheia, display externo/Sidecar com espelhamento para vidro de teleprompter. **Hide from screen share** esconde o overlay em gravações/calls.

## Remoto
- **Remote Connection** (porta 7373): ver o prompter no celular via navegador + QR code.
- **Director Mode** (porta 7575): outra pessoa escreve/edita e envia o roteiro em tempo real.
Use só em rede local confiável — tráfego é direto, sem servidor intermediário.

## Privacidade
Sem contas/analytics. No Word Tracking, o reconhecimento de fala do macOS pode enviar áudio à Apple dependendo da configuração do sistema — avise em conteúdo sensível.

## Verificação
Colar roteiro curto, play, ler em voz alta: as palavras devem acender em sincronia.
