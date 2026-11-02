# 🧰 Claude Arsenal

**30 skills de especialista para o Claude Code + um roteador que escolhe a ferramenta certa sozinho.**

Vídeo, automação de navegador, CRM no WhatsApp, e-mail próprio, self-hosting, observabilidade, IA/RAG, segurança de agentes — cada ferramenta open source vira uma skill com instalação verificada, fluxos de especialista, armadilhas e um passo de verificação.

> Comandos verificados nos READMEs oficiais de cada projeto em **02/11/2026**.

## Como funciona

```
Você: "preciso cortar esse podcast em clipes pro TikTok e agendar"
        │
        ▼
 /arsenal (roteador)  ──►  bridgeclip  ──►  ffmpeg  ──►  cogsend
 carregado automaticamente pela descrição da skill
```

- **Automático**: cada `SKILL.md` tem uma `description` com gatilhos em PT-BR e EN. O Claude carrega a skill certa quando o pedido combina — você não precisa lembrar o comando.
- **Manual**: `/dockge`, `/ffmpeg`, `/arsenal`… força a skill.
- **Pipelines**: o roteador `arsenal` conhece combos prontos (fábrica de conteúdo, servidor self-hosted, negócio por WhatsApp, agentes seguros, produto de IA).

## Instalação

### Opção 1 — Plugin (recomendado, atualiza com um comando)
No Claude Code:
```
/plugin marketplace add blackandin-enzoeisabella/claude-arsenal
/plugin install arsenal@claude-arsenal
```
Comandos ficam com namespace: `/arsenal:dockge`, `/arsenal:arsenal`. Atualizar: `/plugin marketplace update claude-arsenal`.

### Opção 2 — Script (comandos curtos: `/dockge`)
```bash
curl -fsSL https://raw.githubusercontent.com/blackandin-enzoeisabella/claude-arsenal/main/scripts/install.sh | bash
```
Ou com clone (permite `--link`, que atualiza com `git pull`):
```bash
git clone https://github.com/blackandin-enzoeisabella/claude-arsenal.git
cd claude-arsenal
bash scripts/install.sh --link              # global (~/.claude/skills)
bash scripts/install.sh --project           # só no projeto atual (.claude/skills)
bash scripts/install.sh --only dockge,logdeck,openobserve
bash scripts/install.sh --uninstall
```
Windows: `powershell -ExecutionPolicy Bypass -File scripts\install.ps1`

Reinicie o Claude Code depois de instalar.

### Opção 3 — claude.ai / app
Compacte a pasta de uma skill (ex.: `skills/dockge/`) em `.zip` e envie em **Configurações → Capacidades → Skills**.

## Catálogo

Veja **[CATALOG.md](CATALOG.md)** — tabela completa de comandos, ferramentas e repositórios.

| Área | Skills |
|---|---|
| 🎬 Vídeo e áudio | `openreel` · `ffmpeg` · `bridgeclip` · `recordly` · `textream` · `handy` |
| 🌐 Web e automação | `agent-browser` · `open-seo` · `excalidraw-mcp` · `gods-eye-view` |
| 💼 Negócio | `deskcomm-crm` · `mailflare` · `open-archiver` · `cogsend` · `taskosaur` · `presenton` |
| 🖥️ Infra self-hosted | `dockge` · `logdeck` · `openobserve` · `webssh` · `sqlit` · `breakscale` |
| 🤖 IA e agentes | `dify` · `openwork` · `emdash` · `vibecraft` |
| 🔒 Segurança | `safety-net` · `pasteguard` |
| 🏠 Pessoal | `ezbookkeeping` · `kept` |

## Anatomia de uma skill

```markdown
---
name: dockge
description: <o que é + quando usar + gatilhos>   ← é isso que faz o Claude carregar sozinho
---
# Dockge
Repo · licença · plataforma
## Instalação           comandos verificados
## Fluxos de especialista   opinião, não só documentação
## Armadilhas           o que costuma dar errado
## Verificação          como provar que funcionou
```

## Adicionar uma nova ferramenta
1. `mkdir skills/<nome-kebab>` e crie `SKILL.md` seguindo a anatomia acima.
2. Adicione a linha no roteador (`skills/arsenal/SKILL.md`) e no `CATALOG.md`.
3. `python3 scripts/validate.py` — o CI roda o mesmo validador em cada push.

## Estrutura
```
claude-arsenal/
├── .claude-plugin/        plugin.json + marketplace.json
├── skills/<nome>/SKILL.md 31 skills (30 ferramentas + roteador)
├── scripts/               install.sh · install.ps1 · validate.py
├── .github/workflows/     validação automática
└── CATALOG.md
```

## Aviso
As skills ensinam a usar projetos de terceiros; cada um tem sua própria licença (MIT, Apache, GPL, BSL…). Leia antes de uso comercial. Comandos podem mudar com novas versões — cada skill aponta o repositório oficial.

Licença deste repositório: MIT.
