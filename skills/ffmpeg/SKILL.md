---
name: ffmpeg
description: Especialista em FFmpeg e no ffmpeg-skill (kajisho5), motor local de edição de vídeo para agentes com 42 ferramentas, contrato legível por máquina e verificação pós-execução. Use para cortar, juntar, converter, comprimir, reenquadrar 9:16, legendar (inclusive por transcrição local), normalizar loudness, extrair áudio, gerar thumbnails e exportar para TikTok/Reels/Shorts/YouTube. Triggers - ffmpeg, ffprobe, converter vídeo, cortar vídeo, comprimir vídeo, legenda, reels, tiktok, shorts, loudness, mp4.
---

# FFmpeg (+ ffmpeg-skill)

Repo: https://github.com/kajisho5/ffmpeg-skill (camada para agentes: sem nuvem, sem chave, só Python stdlib) · Motor: https://ffmpeg.org

## Instalação
```bash
sudo apt install ffmpeg          # macOS: brew install ffmpeg | Windows: winget install ffmpeg
npx ffmpeg-skill                 # instala em ~/.claude/skills/ffmpeg-skill (--cursor, --codex, --all)
npx ffmpeg-skill doctor          # checa ffmpeg/ffprobe e filtros necessários
pip install faster-whisper       # opcional: legendas por transcrição local
```
Re-rodar `npx ffmpeg-skill` atualiza a cópia (não atualiza sozinha).

## Disciplina obrigatória: probe → editar → verificar
1. **Probe** sempre primeiro — decida por medidas reais (duração, fps, resolução, áudio), nunca pelo nome do arquivo:
   `ffprobe -v error -show_streams -show_format -of json in.mp4`
2. **Edite sem perda quando der** (`-c copy`); re-encode só se o filtro exigir.
3. **Verifique** o resultado com ffprobe (duração, codecs, resolução) e, se a imagem mudou, gere contact sheet.

## Com ffmpeg-skill instalado (preferido)
```bash
S=~/.claude/skills/ffmpeg-skill/scripts
python3 $S/probe.py in.mp4 --compact
python3 $S/cut.py in.mp4 --segments 0:45-3:10,5:00-6:30
python3 $S/render.py talk.mp4 --template tiktok --cues cues.txt   # 9:16, legendas fora das áreas de UI, -14 LUFS
python3 $S/render.py talk.mp4 --template all                      # tiktok, reels, shorts, youtube, x, linkedin, facebook
python3 $S/render.py --list-templates
npx ffmpeg-skill contract --json   # o que cada ferramenta aceita/gera/verifica
```
Use `--dry-run` para ver os comandos planejados.

## FFmpeg puro — receitas confiáveis
```bash
# cortar sem re-encode (corte cai no keyframe mais próximo)
ffmpeg -ss 00:00:45 -to 00:03:10 -i in.mp4 -c copy corte.mp4
# corte preciso (re-encode)
ffmpeg -i in.mp4 -ss 45 -to 190 -c:v libx264 -crf 20 -preset veryfast -c:a aac -b:a 160k corte.mp4
# comprimir para web
ffmpeg -i in.mp4 -c:v libx264 -crf 23 -preset veryfast -movflags +faststart -c:a aac -b:a 128k web.mp4
# vertical 9:16 com crop central
ffmpeg -i in.mp4 -vf "crop=ih*9/16:ih,scale=1080:1920" -c:v libx264 -crf 20 -preset veryfast -c:a copy vertical.mp4
# normalizar loudness para redes (-14 LUFS)
ffmpeg -i in.mp4 -af loudnorm=I=-14:TP=-1.5:LRA=11 -c:v copy out.mp4
# queimar legendas .srt
ffmpeg -i in.mp4 -vf subtitles=leg.srt -c:a copy legendado.mp4
# extrair áudio / thumbnail
ffmpeg -i in.mp4 -vn -c:a libmp3lame -q:a 2 audio.mp3
ffmpeg -ss 5 -i in.mp4 -frames:v 1 thumb.jpg
# juntar arquivos iguais (mesmo codec)
printf "file '%s'\n" a.mp4 b.mp4 > lista.txt && ffmpeg -f concat -safe 0 -i lista.txt -c copy junto.mp4
# frame rate variável → constante
ffmpeg -i tela.mp4 -r 30 -c:v libx264 -crf 20 -preset veryfast -c:a aac cfr.mp4
```

## Armadilhas
- Use `-preset veryfast` salvo pedido de qualidade máxima (presets lentos custam 2–3× o tempo).
- `-c copy` + `-ss` antes do `-i` corta no keyframe: pode sobrar/faltar ~1s.
- `concat` com codecs diferentes falha — normalize antes.
- Nunca sobrescreva o original; escreva em arquivo novo.
- Nunca monte filtergraph a partir de texto do usuário sem validar (injeção de argumentos).

## Verificação
`ffprobe` do resultado confere duração esperada, codec (h264/aac), resolução e loudness (`-af ebur128` se crítico).
