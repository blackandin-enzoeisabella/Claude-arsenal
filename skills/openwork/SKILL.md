---
name: openwork
description: Especialista no OpenWork (different-ai), alternativa open source ao Claude Cowork e Codex - app desktop onde agentes de IA trabalham nos seus arquivos com qualquer modelo (API própria, ChatGPT, Ollama), e um MCP que leva skills, plugins e conexões compartilhadas para Claude Code, Codex, Cursor e OpenCode. Use para instalar o OpenWork, conectar seu MCP, compartilhar skills com time, migrar setup do Cowork ou rodar com modelos locais. Triggers - openwork, cowork alternativo, open source cowork, compartilhar skills com time, mcp openwork, openwork den.
---

# OpenWork

Repo: https://github.com/different-ai/openwork · app MIT (fora de `ee/`) · macOS/Windows/Linux

## Duas formas de usar
1. **App desktop** — workspace onde agentes trabalham nos seus arquivos locais. Qualquer modelo: chave própria, login ChatGPT, Ollama ou servidor OpenAI-compatível.
2. **MCP do OpenWork** no agente que você já usa — traz suas skills, plugins, conexões MCP, Google Workspace e Microsoft 365.

## Instalar (pelo próprio agente)
Cole no Claude Code:
```text
Install OpenWork on my computer, set up my first workspace, and open it ready to use. Follow the steps in https://openworklabs.com/start.md?v=hero
```
Ou baixe em GitHub Releases / site.

## Conectar o MCP
```bash
claude mcp add --transport http openwork https://api.openworklabs.com/mcp/agent
codex mcp add openwork --url https://api.openworklabs.com/mcp/agent
```
OpenCode (`opencode.json`): `{"mcp":{"openwork":{"type":"remote","enabled":true,"url":"https://api.openworklabs.com/mcp/agent","oauth":{}}}}`

Ferramentas expostas: `search_capabilities`, `execute_capability`, `list_skills`, `get_skill`.

## Quando faz sentido
- Você quer **as mesmas skills** (como este arsenal) em vários agentes/colegas sem copiar pastas.
- Quer experiência tipo Cowork com **modelo local** (privacidade) ou outro provedor.
- Times: **OpenWork Den** (control plane, licença EE source-available) para provisionar modelos, políticas e marketplace de skills.

## Migrar do Cowork / reaproveitar este arsenal
Skills e plugins compatíveis com Claude transferem. Para publicar este repositório como capacidade do time, importe o plugin pelo Den/marketplace conforme os docs.

## Contribuir (dev)
Node 24 (`.nvmrc`) + pnpm 11 via `corepack enable`. **Nunca npm/yarn** neste repo.

## Armadilhas
- MCP remoto usa OAuth com a conta OpenWork — dados passam pelo serviço deles; modo 100% local = app desktop + Ollama.
- Licença dividida: código em `ee/` não é MIT.

## Verificação
Após `claude mcp add`, rodar `/mcp` no Claude Code: `openwork` conectado; `list_skills` retorna suas skills.
