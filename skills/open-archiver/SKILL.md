---
name: open-archiver
description: Especialista no Open Archiver, plataforma self-hosted de arquivamento de e-mail com conformidade legal (ingestão IMAP, Google Workspace, Microsoft 365, PST, mbox, eml), busca full-text em e-mails e anexos, retenção, legal hold, hash de integridade e trilha de auditoria. Use para instalar, configurar fontes de ingestão, políticas de retenção, eDiscovery e backups de e-mail. Triggers - open archiver, openarchiver, arquivar e-mail, backup de email, compliance de e-mail, ediscovery, pst, mbox.
---

# Open Archiver

Repo: https://github.com/LogicLabs-OU/OpenArchiver · SvelteKit + Node/Express + PostgreSQL + Meilisearch + Valkey(Redis)/BullMQ · Docker Compose

## Quando usar
- Empresa precisa guardar e-mails por exigência legal/fiscal, ou migrar/arquivar contas (Gmail, M365) antes de cancelar.
- Busca em anos de e-mails + anexos (PDF, DOCX).
- **Não é cliente de e-mail** — para enviar/receber use `mailflare`.

## Requisitos
Docker + Compose, ≥ 4 GB de RAM (2 GB se Postgres/Valkey/Meilisearch forem externos). Disco proporcional ao volume (há deduplicação e compressão).

## Instalação
```bash
git clone https://github.com/LogicLabs-OU/OpenArchiver.git
cd OpenArchiver
cp .env.example .env      # definir senhas de admin, chaves secretas, storage
docker compose up -d
```
Acesso: `http://localhost:3000`. Demo: https://demo.openarchiver.com

## Configuração
1. **Fontes de ingestão**: IMAP genérico, Google Workspace, Microsoft 365, PST, `.eml` zipados, mbox. Import inicial em massa + sincronização contínua. Guias de cada fonte nos docs do projeto.
2. **Storage**: filesystem local ou S3-compatível (AWS S3, MinIO, R2). Para produção, S3 com versionamento.
3. **Retenção**: políticas por regra; **legal hold** impede exclusão durante litígio.
4. **Integridade**: hashes gravados na ingestão; cada e-mail tem "Integrity Report".

## Opinião de especialista
- Defina a política de retenção **antes** de importar (ex.: fiscal BR costuma pedir 5 anos — confirme com o contador/jurídico).
- Backup do Postgres (metadados/auditoria) **e** do storage; um sem o outro não restaura.
- Exponha só atrás de HTTPS + rede privada/VPN; é um cofre de dados pessoais (LGPD).
- Para análise com IA, existe um MCP comunitário (`arnd/openarchiver-mcp`) — avalie o código antes de dar acesso ao arquivo inteiro.

## Verificação
`docker compose ps` todos healthy; login ok; uma fonte de teste importa e a busca encontra um e-mail por palavra do anexo.
