---
name: "fdd-tracken"
description: "Cria tasks do MeisterTask e FDDs enxutos para projetos TRACKen, na ordem task, validação e documento. Use ao planejar, quebrar tarefas ou documentar uma feature."
---

# FDD e tasks TRACKen

Processo para transformar uma demanda em task do MeisterTask e, depois de validada, em um FDD enxuto. Tudo em português do Brasil. Nunca usar travessão (—).

## Ordem obrigatória

1. **Levantamento:** entender a demanda com perguntas objetivas, uma de cada vez. Quando houver dúvida, oferecer 2 a 4 opções marcadas como hipótese.
2. **Task primeiro:** entregar a task do MeisterTask (título, descrição e checklist). Não escrever o FDD nesta etapa.
3. **Validação:** o usuário lança a task e discute com o dev. Antes de escrever o FDD, confirmar:
   - O dev confirmou que o escopo é viável.
   - Telas e textos (botões, status, pop-ups) estão definidos ou listados como ponto em aberto.
   - Toda pendência está listada em Dependências ou em Pontos em aberto, nunca escondida no texto.
   - O escopo tem só o que é desenvolvível: sem piloto e sem prazos.
   Se algo não estiver claro, perguntar antes de escrever.
4. **FDD:** gerar a partir da task validada, no modelo abaixo. Se houver conector do Google Drive, criar o documento como Google Doc; senão, entregar .docx. Na task vai o link, não o arquivo.
5. **Mudanças:** atualizar o documento existente e sugerir um comentário curto na task com o que mudou.

## Formato da task do MeisterTask

- Entregar título, descrição e checklist, cada um em seu próprio bloco de código, para colar.
- **Sem negrito nem itálico:** o MeisterTask não renderiza.
- Usar emojis de seção e o separador `━━━━━━━━━━━━━━━━━━━━` entre blocos.
- Seções usuais: 🎯 OBJETIVO, ⚠️ PONTOS IMPORTANTES (quando houver), 📌 CONTEXTO, 🛠️ ESCOPO (✔️ itens), 🔗 DEPENDÊNCIAS (🔹), ❓ PONTOS EM ABERTO (quando houver), 📄 REFERÊNCIA.
- Não incluir fora do escopo, prazos nem piloto, a menos que o usuário peça.
- Checklist: no máximo 16 itens, um por linha, verbos no infinitivo, só itens desenvolvíveis.
- Preferir poucas tasks por assunto a muitas tasks pequenas.

## Modelo do FDD (somente estas seções)

```
FDD: [projeto] · [nome da task]
Data: [data]
Desenvolvedor: [nome]

1. Contexto
2. Premissas
3. Escopo
4. Fluxos (principal e exceções) + fluxograma opcional
5. Dependências (o que depende de outra pessoa, time ou task, com responsável)
6. Pontos em aberto (decisões pendentes, com quem decide)
7. Critérios de aceite (checklist verificável)
```

- Não incluir fora do escopo, objetivos, contratos, erros, observabilidade, riscos, prazos, piloto nem imagens de tela. Protótipos ficam anexados na task.
- O fluxograma é o único elemento visual permitido.
- Se não houver dependências ou pontos em aberto, escrever "Nenhum" na seção.
- Texto conciso: frases curtas, uma ideia por item.

## Regras de conteúdo

- Nomes de status, botões e textos precisam ser os mesmos em todas as telas, e-mails e pop-ups.
- Pop-ups: título curto, uma frase dizendo o que acontece, botões que dizem a ação (nunca Sim/Não).
- Telas, modais e confirmações citam o número da solicitação e o nome da loja quando aplicável.
- Marcar como hipótese tudo que não foi confirmado pelo usuário.
- Quando uma decisão nova contradiz uma anterior, apontar a contradição e perguntar antes de seguir.