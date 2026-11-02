---
name: deskcomm-crm
description: Especialista no DeskcommCRM, CRM open source self-hosted com agentes de IA que atendem, qualificam e vendem no WhatsApp (WAHA), multi-tenant, LGPD, alternativa ao Kommo/Octadesk/Intercom. Use para instalar o CRM em VPS, configurar cliente por nicho, conectar WhatsApp, ajustar o prompt do agente de vendas, automações e atualizar a versão. Triggers - deskcomm, deskcommcrm, crm whatsapp, agente de vendas no whatsapp, waha, kommo alternativo.
---

# DeskcommCRM

Repo: https://github.com/melgarafael/DeskcommCRM · App + WhatsApp (WAHA) + Supabase/Postgres · Docker · documentação em PT-BR

## Quando usar
Negócio que vende por chat (WhatsApp) e quer CRM próprio com agentes de IA, sem mensalidade por usuário. Ótimo produto para **freelancer revender implantação** por nicho.

## Pré-requisitos
- VPS Linux (o projeto recomenda datacenter em São Paulo para WhatsApp 24/7), domínio apontado para o IP.
- Supabase: o instalador cria sozinho se você exportar `SUPABASE_ACCESS_TOKEN` antes.
- Docker: o instalador oferece instalar se faltar.

## Instalação (caminho principal)
```bash
ssh root@SEU_IP
git clone https://github.com/melgarafael/DeskcommCRM.git
cd DeskcommCRM
bash hostgator-setup-kit/install.sh          # interativo, idempotente
# não-interativo:
cp .env.hostgator.example .env  # preencher
bash hostgator-setup-kit/install.sh --yes
```
O instalador valida cada resposta, gera os segredos, aplica `supabase/baseline.sql`, cria o admin, sobe com HTTPS automático, instala o **cron de automações** e o **agente de atualização**. Rodar de novo não quebra nada.

Outro host (Hostinger, Coolify, Dokploy, CapRover): o instalador detecta proxy reverso existente nas portas 80/443 e publica atrás dele.

## Guias de assistente oficiais (use-os!)
O repo traz skills próprias em `.agents/skills/` (instalar, cliente novo por nicho, métricas, prompt do agente). Para tê-las em qualquer pasta:
```bash
curl -fsSL https://raw.githubusercontent.com/melgarafael/DeskcommCRM/main/scripts/instalar-guias.sh | bash
```
Depois: `/deskcomm-instalar`. Com o repo clonado, elas já vêm junto. **Prefira essas guias para detalhes de configuração de cliente** — esta skill é o mapa geral.

## Pós-instalação
1. Abrir `https://<dominio>` (cadeado leva ~1 min), entrar como admin.
2. Onboarding: escanear QR code com o WhatsApp do número de vendas.
3. 2FA opcional em Configurações › Segurança (recomendado para admin).
4. Montar prompt do agente por nicho; testar com um número próprio antes de ligar para clientes.

## Atualização
Rodapé da sidebar mostra **"Nova versão"** → Configurações → Atualizar: faz backup do banco, atualiza e faz rollback automático se a nova versão subir quebrada.

## Armadilhas
- Sem o cron de automações, regras QUANDO/SE/ENTÃO acumulam na fila — confira que foi instalado.
- WhatsApp não oficial (WAHA) tem risco de banimento em disparo em massa: use para atendimento, não spam.
- LGPD: defina retenção e base legal; não importe listas compradas.

## Verificação
HTTPS válido no domínio, login admin ok, WhatsApp conectado (status no painel), mensagem de teste respondida pelo agente.
