#!/usr/bin/env python3
"""Valida todas as skills: frontmatter, nome = pasta, descrição, seções obrigatórias.
Também confere se o roteador (arsenal) referencia todas as skills e se o CATALOG.md lista todas.
Uso: python3 scripts/validate.py   (sai com código 1 se houver erro)
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SKILLS = ROOT / "skills"
NAME_RE = re.compile(r"^[a-z0-9]+(-[a-z0-9]+)*$")
errors: list[str] = []


def frontmatter(text: str) -> dict:
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if not m:
        return {}
    data = {}
    for line in m.group(1).splitlines():
        if ":" in line:
            k, v = line.split(":", 1)
            data[k.strip()] = v.strip()
    return data


names = []
for d in sorted(p for p in SKILLS.iterdir() if p.is_dir()):
    f = d / "SKILL.md"
    if not f.exists():
        errors.append(f"{d.name}: falta SKILL.md")
        continue
    text = f.read_text(encoding="utf-8")
    fm = frontmatter(text)
    name, desc = fm.get("name", ""), fm.get("description", "")
    names.append(d.name)
    if name != d.name:
        errors.append(f"{d.name}: name '{name}' difere da pasta")
    if not NAME_RE.match(name) or len(name) > 64:
        errors.append(f"{d.name}: name inválido (kebab-case, <=64)")
    if "claude" in name or "anthropic" in name:
        errors.append(f"{d.name}: name não deve conter 'claude'/'anthropic'")
    if not (50 <= len(desc) <= 1024):
        errors.append(f"{d.name}: description com {len(desc)} chars (50-1024)")
    if "<" in desc or ">" in desc:
        errors.append(f"{d.name}: description não pode ter < ou >")
    if d.name != "arsenal":
        for sec in ("## Verificação",):
            if sec not in text:
                errors.append(f"{d.name}: falta seção '{sec}'")
        if "Repo:" not in text:
            errors.append(f"{d.name}: falta linha 'Repo:'")

router = (SKILLS / "arsenal" / "SKILL.md").read_text(encoding="utf-8")
catalog = (ROOT / "CATALOG.md").read_text(encoding="utf-8") if (ROOT / "CATALOG.md").exists() else ""
for n in names:
    if n == "arsenal":
        continue
    if f"`{n}`" not in router:
        errors.append(f"roteador não referencia `{n}`")
    if f"`/{n}`" not in catalog:
        errors.append(f"CATALOG.md não lista `/{n}`")

for j in (ROOT / ".claude-plugin").glob("*.json"):
    try:
        json.loads(j.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        errors.append(f"{j.name}: JSON inválido ({e})")

if errors:
    print("❌ Erros encontrados:")
    for e in errors:
        print("  -", e)
    sys.exit(1)
print(f"✅ {len(names)} skills válidas")
