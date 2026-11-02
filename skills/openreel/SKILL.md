---
name: openreel
description: Especialista no OpenReel Video, editor de vídeo open source no navegador/desktop (alternativa ao CapCut, sem marca d'água, MIT). Use quando o usuário quiser editar vídeo com timeline visual, adicionar legendas, música, transições, cor, exportar vídeo para redes, rodar o OpenReel localmente ou fazer edições com o AI Editor/MCP do OpenReel. Triggers - openreel, editor de vídeo no navegador, capcut alternativo, timeline, editar vídeo sem marca d'água.
---

# OpenReel Video

Repo: https://github.com/Augani/openreel-video · Licença MIT · Navegador (Chrome/Edge) + desktop alpha (macOS/Windows/Linux)

Editor de vídeo com timeline, preview ao vivo, legendas, mixagem de áudio, cor e transições. Edição e renderização acontecem **no dispositivo** (WebCodecs/WebGPU) — nada sobe para servidor.

## Quando usar / quando não
- **Use** para edição criativa com olho humano: montar sequência, ajustar ritmo, títulos, música.
- **Não use** para lote/automação (converter 50 arquivos, normalizar loudness) → skill `ffmpeg`.
- Clipes automáticos de vídeo longo → `bridgeclip`.

## Instalação
Sem instalar: abrir a versão web do editor (link no README). Para rodar local ou hospedar sua cópia:

```bash
git clone https://github.com/Augani/openreel-video.git
cd openreel-video
pnpm install          # use a versão de pnpm declarada no package.json (corepack enable)
pnpm dev              # abre em http://localhost:5173
# produção
pnpm build && pnpm preview
```
Desktop: baixar build em Releases (alpha — avise o usuário).

## Fluxo de edição padrão
1. Criar projeto → importar mídia → arrastar para a timeline.
2. Cortes, legendas, música, cor, transições.
3. Exportar com preset (ou configurações próprias).
4. **Exportar o arquivo de projeto** como backup — o armazenamento do navegador pode ser limpo.

## Edição com IA
- Painel **AI Editor**: descreve a edição em linguagem natural (cortar clipe, adicionar título, ajustar transform, montar sequência). Edições são reversíveis.
- Configurar em **Settings → AI Editor** com chave própria (OpenAI, Anthropic ou endpoint compatível). Uso de provedor tem custo.
- O **desktop suporta clientes MCP**: um assistente externo pode operar o editor. Consulte o guia de IA do repo para configurar.

## Armadilhas
- Suporte a codec, memória e GPU variam por navegador; 4K pede muita RAM. Se o export falhar no navegador, use o desktop ou pré-converta com `ffmpeg` (H.264/AAC, 30fps constante).
- Mídia com frame rate variável (gravações de celular/tela) causa dessincronia: normalize antes (`ffmpeg -i in.mp4 -r 30 -c:v libx264 -c:a aac out.mp4`).
- Projetos ficam no storage do navegador: sempre exporte o projeto + mantenha mídia original.

## Verificação
- `pnpm dev` respondeu na URL do Vite; um export curto (5s) gera arquivo reproduzível.
- Para contribuir: `pnpm typecheck && pnpm test && pnpm lint`.
