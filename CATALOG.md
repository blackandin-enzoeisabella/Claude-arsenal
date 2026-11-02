# Catálogo de comandos

Instalado via `scripts/install.sh` → comandos sem prefixo (`/dockge`).
Instalado como plugin → mesmo comando com namespace (`/arsenal:dockge`).
Você **não precisa** digitar o comando: o Claude carrega a skill sozinho quando o pedido combina com a descrição dela. O comando serve para forçar.

| Você pediu | Comando | Ferramenta | Repo |
|---|---|---|---|
| (roteador) | `/arsenal` | Escolhe a ferramenta certa e monta pipelines | — |
| /OpenReel | `/openreel` | Editor de vídeo no navegador | [Augani/openreel-video](https://github.com/Augani/openreel-video) |
| /Agent Browser | `/agent-browser` | Automação de navegador para agentes | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |
| /DeskcommCRM | `/deskcomm-crm` | CRM com IA no WhatsApp | [melgarafael/DeskcommCRM](https://github.com/melgarafael/DeskcommCRM) |
| /Textream | `/textream` | Teleprompter macOS/iOS | [f/textream](https://github.com/f/textream) |
| /God's Eye View | `/gods-eye-view` | Globo 3D OSINT ao vivo | [bilawalsidhu/gods-eye-view](https://github.com/bilawalsidhu/gods-eye-view) |
| /vibecraff | `/vibecraft` | Visualização 3D do Claude Code | [Nearcyan/vibecraft](https://github.com/Nearcyan/vibecraft) |
| /FFmpeg Skill | `/ffmpeg` | FFmpeg + ffmpeg-skill | [kajisho5/ffmpeg-skill](https://github.com/kajisho5/ffmpeg-skill) |
| /Excalidraw MCP | `/excalidraw-mcp` | Diagramas via MCP | [excalidraw/excalidraw-mcp](https://github.com/excalidraw/excalidraw-mcp) |
| /Open Archiver | `/open-archiver` | Arquivamento de e-mail | [LogicLabs-OU/OpenArchiver](https://github.com/LogicLabs-OU/OpenArchiver) |
| /open seo | `/open-seo` | SEO (Semrush/Ahrefs open source) | [every-app/open-seo](https://github.com/every-app/open-seo) |
| /pasteguard | `/pasteguard` | Máscara de PII/segredos para LLM | [sgasser/pasteguard](https://github.com/sgasser/pasteguard) |
| /Emdash | `/emdash` | Agentes de código em paralelo | [generalaction/emdash](https://github.com/generalaction/emdash) |
| /openwork | `/openwork` | Alternativa open source ao Cowork | [different-ai/openwork](https://github.com/different-ai/openwork) |
| /bridgeClip | `/bridgeclip` | Clipes de vídeo longo com IA | [bridge-mind/bridgeclip](https://github.com/bridge-mind/bridgeclip) |
| /claude code safety net | `/safety-net` | Bloqueio de comandos destrutivos | [kenryu42/cc-safety-net](https://github.com/kenryu42/cc-safety-net) |
| /cogsend | `/cogsend` | Agendador de redes sociais | [cogsend/cogsend](https://github.com/cogsend/cogsend) |
| /handy | `/handy` | Ditado por voz offline | [cjpais/Handy](https://github.com/cjpais/Handy) |
| /mailflare | `/mailflare` | E-mail com domínio próprio | [hieunc229/mailflare](https://github.com/hieunc229/mailflare) |
| /webssh | `/webssh` | SSH no navegador | [huashengdun/webssh](https://github.com/huashengdun/webssh) |
| /logdeck | `/logdeck` | Logs e alertas de containers | [AmoabaKelvin/logdeck](https://github.com/AmoabaKelvin/logdeck) |
| /breakscale | `/breakscale` | Simulador de system design | [workersio/breakscale](https://github.com/workersio/breakscale) |
| /recordly | `/recordly` | Gravador de tela para demos | [webadderallorg/Recordly](https://github.com/webadderallorg/Recordly) |
| /kept | `/kept` | Inventário doméstico | [keptinventory/kept](https://github.com/keptinventory/kept) |
| /sqlit | `/sqlit` | SQL no terminal (TUI) | [Maxteabag/sqlit](https://github.com/Maxteabag/sqlit) |
| /ezbookkeeping | `/ezbookkeeping` | Finanças pessoais | [mayswind/ezbookkeeping](https://github.com/mayswind/ezbookkeeping) |
| /Dockge | `/dockge` | Gerenciador de docker compose | [louislam/dockge](https://github.com/louislam/dockge) |
| /openobserve | `/openobserve` | Observabilidade completa | [openobserve/openobserve](https://github.com/openobserve/openobserve) |
| /dify | `/dify` | Plataforma de apps LLM/RAG | [langgenius/dify](https://github.com/langgenius/dify) |
| /taskosaur | `/taskosaur` | Gestão de projetos com IA | [Taskosaur/Taskosaur](https://github.com/Taskosaur/Taskosaur) |
| /presenton | `/presenton` | Apresentações com IA + API | [presenton/presenton](https://github.com/presenton/presenton) |

## Notas de desambiguação
- **vibecraff** → interpretado como **Vibecraft** (Nearcyan), a visualização do Claude Code.
- **Emdash** → o ambiente de agentes (generalaction). Existe também o EmDash CMS (Astro); a skill avisa.
- **kept** → o inventário (keptinventory). Existe também um app de notas homônimo; a skill avisa.
- **/claude code safety net** → `/safety-net` (nomes de skill não podem conter "claude").
- **/FFmpeg Skill** → `/ffmpeg`, para não colidir com a pasta `ffmpeg-skill` que o `npx ffmpeg-skill` instala.
