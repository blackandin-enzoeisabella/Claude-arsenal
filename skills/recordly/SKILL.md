---
name: recordly
description: Especialista no Recordly, gravador e editor de tela open source para demos, tutoriais e vídeos de produto com auto-zoom, cursor suavizado, bolha de webcam, timeline com trims, velocidade e anotações, e extensões. Use para gravar e editar walkthroughs de software, demos de produto, aulas e vídeos para portfolio/landing page, e planejar roteiro de gravação. Triggers - recordly, gravar tela, screen recorder, screen studio alternativo, demo de produto, tutorial em vídeo, walkthrough, gravação com zoom.
---

# Recordly

Repo: https://github.com/webadderallorg/Recordly · macOS 14+, Windows 10 (19041+), Linux

## Instalação
- Releases: https://github.com/webadderallorg/Recordly/releases
- Arch/Manjaro: `yay -S recordly-bin`
- Do código: ver seção Build from source (macOS precisa `xcode-select --install`).

Captura nativa: ScreenCaptureKit (macOS), Windows Graphics Capture + WASAPI (Windows), Electron no Linux (Wayland abre o seletor do sistema ao gravar).

## Fluxo de demo profissional
1. **Roteiro** (o Claude escreve): objetivo do vídeo em 1 frase → 3–5 passos → CTA. Leia com `textream` se tiver narração.
2. **Preparar o ambiente**: resolução 1920×1080 ou 2560×1440, notificações desligadas, dados fictícios (nunca dados reais de cliente), navegador em perfil limpo, zoom do navegador 110–125% para legibilidade.
3. **Gravar** tela inteira ou janela, com microfone e áudio do sistema; webcam opcional.
4. **Editar**: aceite as **sugestões de auto-zoom** e ajuste; trims nos silêncios; speed-up em esperas/carregamentos; anotações de texto nos pontos-chave; cursor smoothing + click bounce.
5. **Moldura**: fundo estilizado, cantos arredondados, sombra.
6. **Exportar** e, se for para redes, passar no `ffmpeg` (9:16, loudness -14 LUFS) e agendar no `cogsend`.

Salve o projeto `.recordly` para reeditar depois.

## Dicas de especialista
- Mova o mouse devagar e pare 1s antes de clicar — o auto-zoom fica muito melhor.
- Vídeo de landing page: 30–60s, sem áudio obrigatório (legenda/anotações), loop limpo (há "cursor loop mode").
- Para portfolio de freela: um vídeo por projeto, mostrando o problema → o fluxo → o resultado.

## Armadilhas
- macOS: conceder permissão de Gravação de Tela e Microfone; reiniciar o app após conceder.
- Linux/Wayland: ocultar cursor pode não funcionar em todos os compositores.

## Verificação
Gravar 10s, aplicar um zoom, exportar e reproduzir o arquivo final.
