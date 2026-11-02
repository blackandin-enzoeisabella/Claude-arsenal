---
name: dockge
description: Especialista no Dockge (louislam, criador do Uptime Kuma), gerenciador self-hosted e reativo de stacks docker compose.yaml com editor interativo, terminal web, conversão de docker run para compose, atualização de imagens e múltiplos agentes/hosts. Use para instalar o Dockge, organizar stacks em /opt/stacks, converter comandos docker run, subir/atualizar serviços self-hosted e gerenciar vários servidores. Triggers - dockge, docker compose ui, gerenciar stacks, portainer alternativo, self-hosted, compose.yaml, subir container.
---

# Dockge

Repo: https://github.com/louislam/dockge · Docker 20+ ou Podman (+ podman-docker) · Linux (Windows ainda não) · amd64/arm64/armv7

Filosofia: seus `compose.yaml` continuam **arquivos normais no disco** — dá para usar `docker compose` na mão em paralelo.

## Instalação
```bash
mkdir -p /opt/stacks /opt/dockge
cd /opt/dockge
curl https://raw.githubusercontent.com/louislam/dockge/master/compose.yaml --output compose.yaml
docker compose up -d
```
`http://localhost:5001`. Pasta de stacks diferente/porta: gerar compose em `https://dockge.kuma.pet/compose.yaml?port=5001&stacksPath=/opt/stacks`.

## Convenções de especialista para stacks
- Uma pasta por stack: `/opt/stacks/<nome>/compose.yaml` + `.env` (fora do git).
- Imagem **com tag fixa** (não `latest`) em produção; atualize de propósito pelo botão "Update".
- Sempre `restart: unless-stopped`, volumes nomeados ou bind em `/opt/stacks/<nome>/data`.
- `healthcheck` em serviços críticos; limites de memória (`mem_limit`) para um serviço não derrubar o host.
- Rede compartilhada `proxy` com Caddy/Traefik para HTTPS; não publique portas de banco no host.

## Stacks deste arsenal que rodam bem no Dockge
`logdeck`, `openobserve`, `ezbookkeeping`, `kept`, `presenton`, `open-archiver`, `open-seo`, `taskosaur`, `dify` (pesado), `pasteguard`.
Use **"Convert docker run"** para transformar os `docker run` das skills em compose.

## Multi-host
Dockge 1.4+: **agents** — gerencie stacks de vários hosts Docker na mesma interface.

## Segurança
O Dockge tem acesso ao socket Docker (= root no host). Não exponha à internet sem HTTPS + autenticação forte; ideal via Tailscale/VPN.

## Verificação
`docker ps | grep dockge` ativo; criar stack de teste (`nginx:alpine`), Start → container sobe e o terminal web mostra os logs.
