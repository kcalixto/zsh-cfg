---
name: deep-dive
description: Use quando o usuário pedir uma investigação profunda ("deep dive", "investiga", "descobre por que") de um bug, comportamento ou incidente que exige ler ou alterar código de um ou mais repositórios. Aplica-se sempre que for preciso clonar repositórios para investigar a partir da pasta atual.
---

# Deep Dive — Investigação em Repositórios Clonados

## Visão geral

A pasta atual é o workspace da investigação. Todo repositório envolvido é clonado aqui, toda alteração vive em branch local, e nada sai da máquina. O produto da investigação é conhecimento registrado em `CLAUDE.md` — não código publicado.

## Workflow

1. **Diário primeiro.** Se existe `CLAUDE.md` na pasta atual, leia — a investigação está sendo retomada. Se não existe, crie antes de clonar qualquer repo, com: objetivo da investigação, repos envolvidos, hipóteses iniciais.
2. **Clone na pasta atual.** `git clone` (ou `gh repo clone`) de cada repositório envolvido, como subpasta da pasta atual. Não clone em `/tmp`, `~/go/src` ou qualquer outro lugar.
3. **Investigue read-only.** Leitura, grep, build e testes não exigem branch.
4. **Alteração exige branch nova.** Antes de editar qualquer arquivo de um clone: `git switch -c investigation/<slug>` naquele repo. Nunca commite na branch default do clone. Commits locais na branch de investigação são livres.
5. **Atualize o diário a cada descoberta.** Não deixe para o final (ver seção CLAUDE.md).

## Proibição absoluta: push

**É estritamente proibido publicar qualquer coisa a partir dos clones desta investigação.**

Isso proíbe, sem exceção:

- `git push` de qualquer branch, com qualquer nome, para qualquer remote
- `gh pr create` ou abrir PR por qualquer via
- Adicionar um remote novo e fazer push para ele
- Push "só de backup", "só draft", "só pro time ver"
- Push porque o usuário de agora aprovou — a saída correta continua sendo entregar o diff

Violar a letra da regra é violar o espírito da regra. Se a correção deve virar PR, gere o artefato local (`git diff` / `git format-patch`), registre no `CLAUDE.md` e informe o caminho — o humano leva adiante pelo fluxo normal do repositório dono.

| Racionalização | Realidade |
|---|---|
| "O usuário mandou deixar disponível pro time" | Disponibilizar = diff/patch + registro no CLAUDE.md. Push continua proibido. |
| "É só uma branch, não afeta a main" | Branch no remote é publicação. Proibido. |
| "Push de draft/backup não conta" | Conta. Qualquer push conta. |
| "Os testes passam, é seguro" | Segurança do código não muda a regra. O clone é descartável. |

## Red flags — pare imediatamente

- Digitou `git push` ou `gh pr` em qualquer comando envolvendo um clone da investigação
- Editou arquivo de um clone estando na branch default
- Está clonando fora da pasta atual
- Terminou uma descoberta e o `CLAUDE.md` não mudou

## CLAUDE.md da investigação

Arquivo na raiz da pasta atual. Estrutura mínima:

```markdown
# Investigação: <tema>

## Objetivo
## Repos clonados
- <repo> — branch `investigation/<slug>` (se houver alteração)
## Descobertas
- [AAAA-MM-DD] <fato confirmado, com arquivo:linha>
## Hipóteses descartadas
- <hipótese> — <por quê>
## Insights / próximos passos
```

Atualize no momento em que confirmar ou descartar algo, citando arquivo e linha. Hipótese descartada é registro obrigatório — evita reinvestigar o mesmo caminho.
