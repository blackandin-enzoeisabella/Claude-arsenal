---
name: bridgeclip
description: Especialista no BridgeClip (BridgeMind), app desktop open source que encontra os melhores momentos em podcasts, lives e entrevistas e exporta clipes verticais 9:16 ou 16:9 com legendas animadas, reenquadramento por rosto e publicação agendada. Use para transformar vídeo longo (arquivo, YouTube, VOD da Twitch) em cortes para TikTok/Reels/Shorts, configurar modelos OpenRouter, estilos de legenda e automações. Triggers - bridgeclip, cortes de podcast, clipes de live, opus clip alternativo, clipar vídeo longo, cortes virais.
---

# BridgeClip

Repo: https://github.com/bridge-mind/bridgeclip · MIT · Electron + React + motor Python · site bridgeclip.ai

Renderização é **local**; IA (transcrição/decisão) usa **sua chave OpenRouter**. Pacotes já trazem Python, FFmpeg e yt-dlp.

## Instalação e primeiro clipe
1. Baixar em bridgeclip.ai ou GitHub Releases (macOS assinado/notarizado; Linux precisa de secret service desbloqueado para salvar chaves).
2. Colar a **chave OpenRouter com crédito** no card de setup.
3. Adicionar vídeo: arquivo local, link público do YouTube ou VOD público concluído da Twitch.
4. Escolher fluxo **Automatic** ou **Review & edit**, enquadramento, duração dos clipes, legendas.
5. Acompanhar em **Jobs**; clipes ficam em **Library** e em `~/BridgeClip`.

## Ajustes que fazem diferença
- Modo **Quality / Economy / Advanced** (modelos próprios). Economy para testar, Quality para publicar.
- Layouts: full-frame, split (dois rostos), fit; enquadramento segue rostos e acomoda screen share.
- 9 estilos de legenda; corte de silêncio; velocidade 1×–2× mantendo tom de voz.
- Rascunho de título/legenda/tags por plataforma (revise antes de aplicar).
- Publicação/agendamento via **Zernio** (conta própria). Alternativa self-hosted: exporte e agende com `cogsend`.
- Assistente: conecta Claude (Pro/Max via Claude Code) ou ChatGPT (via Codex) em Settings → Assistant. Ações que publicam, apagam ou gastam crédito pedem aprovação.

## Opinião de especialista
- Clipe bom = **gancho nos 2 primeiros segundos** + ideia completa (setup e desfecho). Use Review & edit para checar o início de cada corte.
- 30–60s rendem melhor que 90s+ na maioria dos nichos.
- Pós-processo opcional com `ffmpeg` (loudness -14 LUFS, checagem de spec da plataforma).

## Custos e privacidade
Áudio e transcrições vão para a OpenRouter; frames amostrados podem ir em checagens visuais. Veja o custo por execução em Jobs. Use só conteúdo que você tem direito de usar.

## Verificação
Um vídeo de teste de 5–10 min gera ao menos um clipe exportado reproduzível em `~/BridgeClip`.
