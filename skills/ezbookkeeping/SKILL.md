---
name: ezbookkeeping
description: Especialista no ezBookkeeping, app self-hosted leve de finanças pessoais (PWA, multi-moeda, contas e categorias em dois níveis, transações agendadas, importação CSV/Excel/OFX/QIF/MT940/GnuCash/Firefly III, reconhecimento de recibos por IA, 2FA, MCP e scripts de API para agentes). Use para instalar o ezBookkeeping, importar extratos bancários, lançar e consultar gastos, montar categorias e relatórios, e integrar com o Claude. Triggers - ezbookkeeping, finanças pessoais, controle de gastos, importar extrato ofx, firefly alternativo, orçamento pessoal, lançar despesa.
---

# ezBookkeeping

Repo: https://github.com/mayswind/ezbookkeeping · Go · SQLite/MySQL/PostgreSQL · roda em Raspberry Pi/NAS · demo: ezbookkeeping-demo.mayswind.net

## Subir
```bash
docker run -d --name ezbookkeeping -p 8080:8080 \
  -v ezb-data:/ezbookkeeping/data \
  -v ezb-storage:/ezbookkeeping/storage \
  --restart unless-stopped mayswind/ezbookkeeping
# daily build: mayswind/ezbookkeeping:latest-snapshot
```
`data/` guarda o SQLite (`data/ezbookkeeping.db`) e `storage/` os anexos (fotos de recibo) — sem os volumes, tudo some ao recriar o container. Abra `http://localhost:8080`, crie o usuário, ative **2FA**.

## Estrutura recomendada (Brasil)
- **Contas**: Conta corrente (por banco), Cartão de crédito (uma conta por cartão), Dinheiro, Investimentos, Vale-refeição.
- **Categorias (2 níveis)**: Moradia › Aluguel/Condomínio/Luz/Internet; Alimentação › Mercado/Restaurante/Delivery; Transporte; Saúde; Educação; Lazer; Assinaturas; Impostos/Taxas; Renda › Salário/Freela.
- **Tags** para projetos/clientes de freela (separa custo pessoal x trabalho).
- **Transações agendadas** para contas fixas.

## Importar extratos
OFX é o mais confiável (a maioria dos bancos BR exporta). CSV/Excel com **mapeamento de colunas, regras e scripts** — crie regras para categorizar automaticamente (ex.: descrição contém "IFOOD" → Delivery). Importe 1 mês, revise, depois o resto.

## Integração com o Claude
O repo traz uma **Agent Skill oficial** (`skills/ezbookkeeping/` com `scripts/ebktools.sh` / `.ps1`) para registrar e consultar transações, contas, categorias, tags e câmbio via API, além de **MCP** para IA. Para usar: copie a skill oficial para `~/.claude/skills/` e configure URL + token da sua instância conforme o SKILL.md dela:
```bash
sh scripts/ebktools.sh list
sh scripts/ebktools.sh help <comando>
```
Gere um token de API com o menor escopo necessário.

## Opinião de especialista
- Lance diariamente (2 min) ou importe semanalmente; mensalmente vira arqueologia.
- Cartão de crédito como **conta de passivo**: o pagamento da fatura é transferência, não despesa (evita contar gasto em dobro).
- Backup: copie o volume de dados (SQLite) ou faça dump do banco — finanças sem backup é risco.

## Verificação
Container rodando, login com 2FA, importar um OFX de teste e ver os lançamentos categorizados pelas regras.
