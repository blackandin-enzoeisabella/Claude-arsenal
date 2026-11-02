---
name: excalidraw-mcp
description: Especialista no Excalidraw MCP App oficial, servidor MCP que desenha diagramas no estilo à mão do Excalidraw com câmera animada e edição interativa em tela cheia. Use para criar diagramas de arquitetura, fluxogramas, mapas mentais, wireframes rápidos e esboços, conectar o MCP no Claude/Claude Code/VS Code ou hospedar sua própria instância. Triggers - excalidraw, diagrama, desenhar arquitetura, fluxograma, whiteboard, esboço, sketch, mcp excalidraw.
---

# Excalidraw MCP

Repo: https://github.com/excalidraw/excalidraw-mcp · MIT · funciona em clientes com MCP Apps (Claude, ChatGPT, VS Code, Goose)

## Conectar
**Remoto (recomendado):** `https://mcp.excalidraw.com`
```bash
claude mcp add --transport http excalidraw https://mcp.excalidraw.com
```
No claude.ai: Configurações → Conectores → adicionar conector personalizado com essa URL.

**Local – Claude Desktop:** baixar `excalidraw-mcp-app.mcpb` em Releases e dar duplo clique.

**Local – do código:**
```bash
git clone https://github.com/excalidraw/excalidraw-mcp.git
cd excalidraw-mcp && pnpm install && pnpm run build
```
```json
{ "mcpServers": { "excalidraw": { "command": "node", "args": ["/caminho/excalidraw-mcp/dist/index.js", "--stdio"] } } }
```
**Sua instância:** fork → importar na Vercel (sem variáveis) → `https://seu-projeto.vercel.app/mcp`.

## Como pedir bons diagramas
- Nomeie os componentes e as **setas com verbo** ("API → consulta → Postgres").
- Diga a direção do fluxo (esquerda→direita para pipelines, cima→baixo para hierarquias).
- Agrupe por fronteira (frontend / backend / dados / externos) — vira caixas-container.
- Máximo ~12 nós por diagrama; acima disso, quebre em visão geral + detalhes.
- Peça legenda de cores quando houver estados (ok/erro/externo).

Exemplo: "Desenhe a arquitetura: usuário → Next.js na Vercel → FastAPI → Postgres (Supabase); FastAPI → yfinance (externo). Agrupe backend e dados."

## Combina com
- `breakscale` quando o diagrama precisa ser **simulado sob carga**, não só desenhado.
- Exportar e colar em docs/README; para slides use `presenton`.

## Verificação
O diagrama aparece renderizado e editável no cliente; se só vier JSON/texto, o cliente não suporta MCP Apps — use outro cliente ou exporte o `.excalidraw` e abra em excalidraw.com.
