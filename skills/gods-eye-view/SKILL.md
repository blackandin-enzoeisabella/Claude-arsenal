---
name: gods-eye-view
description: Especialista no God's Eye View, globo 3D fotorrealista no navegador com dados públicos ao vivo (aviões, navios, satélites, terremotos, clima, câmeras públicas) e controle por voz com agente de IA. Use para instalar/rodar o projeto, configurar chaves (Cesium, Google Maps, OpenAI), criar cenas e tours de câmera, compartilhar links de alvos rastreados ou estudar OSINT/geovisualização. Triggers - god's eye view, gods eye view, globo 3d, osint, rastrear voos, satélites ao vivo, worldview.
---

# God's Eye View

Repo: https://github.com/bilawalsidhu/gods-eye-view · Node 24.x (≥24.14) ou 26.x · Docker opcional

Globo 3D com camadas de sinais públicos (ADS-B, AIS, elementos orbitais, sismógrafos, câmeras), HUD, modos de sensor (NVG, FLIR, CRT), diretor de cenas e agente de voz.

## Instalação
**Sem chave nenhuma** funciona (imagem Esri + terreno sem chave).

```bash
git clone https://github.com/bilawalsidhu/gods-eye-view.git
cd gods-eye-view
npm ci
npm run doctor      # diagnostica Node/ambiente — rode sempre
npm run dev         # http://localhost:4173
```
Docker (sem Node local):
```bash
docker compose up   # publica só em 127.0.0.1:4173
```
Dados persistem na pasta clonada: `.env` (chaves), `.gev-cache/`, `.gev-logs/`. Backup = copiar a pasta.
Alternativa um-clique: Pinokio ≥ 8.2.

## Chaves (opcionais, no painel POWER UP)
- **Cesium ion token** — 3D fotorrealista (uso pessoal não comercial elegível).
- **Google Maps key** — 3D tiles direto + busca de lugares (cobrado).
- **OpenAI API key** — voz (sob Docker, voz só por API key; MCP local não disponível no Docker).

## Usos
- Clique para rastrear qualquer alvo; "Contacts" lista tudo num raio de 250 km; cockpit view em voos.
- Scene director para tours cinematográficos (ótimo para B-roll de vídeo).
- Share links serializam câmera, camadas e alvo.
- Busca sem geocoder: `geo:-22.9068,-43.1729` ou coordenadas decimais.

## Armadilhas
- Versões antigas consultam servidores Overpass que hoje recusam → Traffic/ALPR vazios: **atualize**.
- Node 25 é EOL e o doctor avisa. Use 24.22.1+ ou 26.12.1+ (correções de segurança de out/2026).
- Embedded browser do Pinokio pode travar: abra a URL local num navegador normal com aceleração.
- **Compartilhar instância** expõe também Provider Settings (suas chaves). Se publicar além do localhost: `GEV_KEY_SETUP_TRUSTED_PEERS=none docker compose up`.
- Ética/legal: dados são públicos, mas não use para perseguir pessoas; câmeras e trajetórias são estimativas.

## Verificação
`npm run doctor` sem erros; `http://localhost:4173` mostra o painel de primeira execução.
