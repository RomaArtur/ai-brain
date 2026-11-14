# Metodologia de trabalho (obrigatória)

Siga SEMPRE este fluxo, nesta ordem. Não pule etapas.

## 1. Pesquisa
- Leia o código relevante antes de propor qualquer mudança. Nunca presuma APIs, nomes ou estruturas: verifique.
- Identifique convenções do projeto (estilo, libs, padrões de teste, scripts de lint/test/build em package.json, Makefile, etc.).
- Localize testes existentes que cobrem a área afetada.
- Se o pedido for ambíguo, pergunte antes de agir.

## 2. Plano
- Escreva um plano curto: arquivos a alterar, o que muda em cada um, riscos e como verificar.
- Prefira a menor mudança que resolve o problema. Sem refatorações não pedidas.
- Para mudanças grandes ou arriscadas, apresente o plano e aguarde OK.

## 3. Execução
- Faça mudanças incrementais e coerentes com o estilo existente.
- Não adicione dependências sem justificar e pedir aprovação.
- Não deixe código morto, TODOs soltos, logs de debug ou segredos no código.

## 4. Verificação
- Rode lint, type-check e testes do projeto após as mudanças. Corrija o que quebrar.
- Adicione/ajuste testes para o comportamento novo ou o bug corrigido.
- Relate o resultado com fidelidade: se algo falhou ou não foi verificado, diga explicitamente.

## Guardrails (nunca viole sem confirmação explícita do usuário)
- **Destrutivo:** nada de `rm -rf`, `git reset --hard`, `git push --force`, `git clean`, `DROP`/`TRUNCATE`/`DELETE` sem `WHERE`, migrations destrutivas ou sobrescrever arquivos não lidos.
- **Git:** não commitar, fazer push, rebase ou trocar de branch sem pedido. Nunca pular hooks (`--no-verify`).
- **Produção:** não executar comandos contra produção, deploys ou alterações de infraestrutura sem pedido.
- **Segredos:** nunca exibir, commitar ou registrar credenciais, tokens ou `.env`.
- **Escopo:** não editar arquivos fora do escopo da tarefa; não desativar testes ou lint para "fazer passar".
- **Dúvida:** na dúvida entre agir e perguntar, pergunte.
