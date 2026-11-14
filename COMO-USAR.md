# Como usar

Catálogo das skills: `GUIA-SKILLS.md`. Este arquivo é o uso do dia, nos três: Cursor, Claude e Antigravity.

No CRM, o `AGENTS.md` ganha de qualquer skill: commit só quando você pedir, teste só do arquivo mexido, e nada de inventar rota, permissão ou campo.

Chame uma skill com `/nome`. O que está marcado **(manual)** só roda assim.

## 1. Os três juntos

Três coisas separadas:

| Eixo | O que decide |
|---|---|
| **Conversa** | O que o modelo relê em todo turno |
| **Branch** | A linha de commits |
| **Pasta** | O que o Apache e o outro agente enxergam |

Dois agentes gravando ao mesmo tempo pedem duas pastas. Cada uma com o seu branch, em `C:\xampp\htdocs\crm-assunto`, no endereço `http://127.0.0.1/crm-assunto/login`. Os atalhos de worktree do Cursor e do Claude nascem fora do Apache. A pasta desta máquina se cria assim:

```powershell
git worktree add -b feat/assunto C:\xampp\htdocs\crm-assunto
```

Use `fix/` quando for correção. `vendor` e `node_modules` são atalho para os da pasta principal. O `.env` é cópia. O `backend/Data` que o git não traz também é cópia. O passo a passo está no `AGENTS.md` §12.

Um branch no mesmo `crm-tracken` basta quando só um agente edita e a pasta principal pode sair da `main`. Neste CRM ela fica na `main`. Feature que vai virar código e tela abre a pasta nova. Conversa que ainda é só decisão (`/grill-me`, plano, spec) não abre pasta.

Vinte agentes gravando ao mesmo tempo são vinte pastas. Agente que só lê, planeja ou revisa não ganha pasta. `vendor` e `node_modules` são atalho. Cada pasta leva cópia do `.env` e do `backend/Data` que o git não traz. O Cursor limpa worktree antiga perto de 25 na máquina, e a pasta em `htdocs` entra nessa conta.

### Juntar

A validação da feature acontece na pasta dela, antes de misturar. Teste do arquivo mexido, tela em `http://127.0.0.1/crm-assunto/`, revisão. Se a `main` andou nesse meio, traga a `main` para dentro dessa pasta, resolva o conflito ali e olhe a tela de novo.

Uma branch por vez entra na pasta principal. Conflito que sobrou se resolve nessa junção, e a tela a conferir passa a ser `http://127.0.0.1/crm-tracken/`.

Com a `main` local do jeito que vai sair, uma vez só: `composer test`, `composer analyse`, `pnpm typecheck`, `pnpm test:unit` e, se o frontend mudou, `pnpm build`. Aí sim `origin/main`, quando você pedir. O pacote de produção sai desse commit já publicado, pelo `build_manual_release.ps1`. Não sai de uma pasta de feature no meio do conflito.

A ordem dos tickets em `.scratch/<assunto>/issues/` é a ordem de juntar: bloqueador primeiro. Os prompts estão na seção 8, em "Pasta e junção".

O que vale nas três: regra compartilhada no `AGENTS.md`. Checklist repetido vira skill. Bloquear um comando perigoso vira hook. Spec em `.scratch/<assunto>/spec.md`. Um ticket por arquivo em `.scratch/<assunto>/issues/`, a partir de `01`, bloqueador primeiro. O caminho está em `docs/agents/issue-tracker.md`.

A tela do CRM, o `backend/Data` e o `.env` ficam no agente desta máquina. A nuvem serve para o que já está no Git remoto e no CI. Não publique o OmniRoute e não mande `.env` nem `backend/Data` para modelo externo.

## 2. Conversa

Fique no fio quando o próximo passo ainda depende do que foi dito. Esvazie quando a próxima tarefa não precisa daquele histórico: o assunto mudou, a mesma correção já falhou duas vezes, ou o spec já está em `.scratch` e a implementação pode começar limpa.

| | Claude Code | Cursor | Antigravity |
|---|---|---|---|
| **Continuar** | O mesmo fio | O mesmo chat | O mesmo fio |
| **Esvaziar e guardar o anterior** | `/clear` (também `/new`). A anterior volta com `/resume`. Dá para nomear: `/clear fluxo-unico`. Fica na mesma janela. `AGENTS.md` e skills continuam. Some o que foi dito. Também tira um `/goal` ativo | Chat novo ao terminar uma feature ou trocar de tarefa. Trocar Agent, Ask, Plan ou Debug abre contexto novo | `/clear` (também `/new`) no CLI |
| **Encurtar e seguir no mesmo assunto** | `/compact`, com um foco do que tem de sobrar. No meio da tarefa, não no fim de uma investigação longa | Resumo do próprio app quando o contexto enche. Fork a partir de uma mensagem corta o que veio depois. Fork do chat inteiro copia tudo e não enxuga | O app resume quando o contexto enche. Não há `/compact` |
| **Bifurcar** | `/branch` copia o histórico, troca você para a cópia e deixa a original no `/resume`. Os dois gravam no mesmo checkout. `/fork` deixa você aqui e manda a cópia para segundo plano, de preferência no worktree dela | Fork a partir de uma mensagem guarda só até ali. Fork do chat inteiro leva todas as mensagens. Side chat não é fork | `/fork` copia o histórico até aqui e mantém o mesmo checkout. Para isolar arquivo, branch ou pasta nova |

`/handoff` deixa um documento quando outra sessão, em outro app, precisa continuar.

## 3. Modelo

O degrau barato do próprio plano cobre consulta, formatação e edição já especificada. Feature que atravessa módulos, bug sutil, tela e sessão longa pedem o degrau forte, na máquina local.

| | Rotina | Difícil ou longo | Consulta barata |
|---|---|---|---|
| **Cursor** | Composer | Grok 4.7, ou o modelo mais capaz da conta | Composer, ou Auto |
| **Claude** | Sonnet. `/model opusplan` planeja no Opus e implementa no Sonnet | Opus. Fable só quando uma sentada não basta | Haiku. Quem nunca troca o modelo está no Opus, que é o padrão da conta e gasta mais |
| **Antigravity** | Orchestrator: o forte planeja, o Hydrogen executa | Carbon ou Argon direto, esforço alto | Hydrogen direto, esforço baixo, quando a tarefa já está fechada |

Esforço é o quanto o modelo pensa antes de responder. Sobe a qualidade e o gasto. Não troca o modelo.

| Nível | Quando |
|---|---|
| Baixo | Consulta, renomear, primeiro esboço que você vai revisar |
| Médio | O dia a dia. No Claude, Opus e Sonnet atuais já começam aqui |
| Alto | Borda, verificação, bug sutil, refactor de vários arquivos |
| Extra (`xhigh`) | Tarefa longa de agente. No Antigravity o seletor chama Extra |
| Max | O mais fundo, sem você olhando. No Claude vale só nesta sessão e pensa demais |

No **Claude**, `/effort low|medium|high|xhigh|max`. Escrever "think hard" no pedido não muda esse teto. `/ultracode` é outra chave: para cada tarefa grande, ele monta um fluxo com vários passos. `/fast on` acelera a resposta do modelo atual. Se você ligar no meio de uma resposta, essa resposta termina na velocidade antiga.

No **Cursor**, Fast é uma variante do modelo, mais cara. No Composer 2.5 ela é o padrão do produto. No Grok 4.7, o fast dobra o preço. Max Mode, nos planos antigos por request, só libera a janela maior. Não é um nível de pensamento.

No **Antigravity** os níveis estão no seletor (Low, Medium, High, Extra) e na CLI em `/effort`, até `max` nos modelos que publicam esse teto. O Orchestrator não aceita esforço: o plano já é do modelo forte e a execução é do Hydrogen. Não há um botão Fast separado. O caminho rápido é Hydrogen direto, em esforço baixo.

## 4. O que deixar configurado

**Cursor.** Modo Agent no dia a dia. Plan para mudança grande. Ask para só ler. Debug quando a causa não aparece na leitura e dá para reproduzir. Design para clicar no elemento. Skill que uma automação precisa tem de estar em `.cursor/skills/` do repositório. A de `~/.cursor/skills/` não entra na automação.

`/multitask` fica na janela de agentes, não no editor. Ele tira os pedidos da fila e roda em paralelo, ou parte uma tarefa grande em pedaços. No plano, o botão é **Build in Parallel**: o que não depende entre si sai junto, o que depende espera a ordem. Use quando os pedaços não mexem nos mesmos arquivos, ou quando você quer continuar perguntando enquanto o resto anda. Uma tela só, ou dois pedaços no mesmo arquivo, segue na fila, um de cada vez. A pasta que o Apache abre continua sendo a de `htdocs`. O worktree automático do Cursor nasce fora dela.

**Claude.** O `AGENTS.md` do repo já entra. `CLAUDE.md`, se existir, fica abaixo de 200 linhas: comando de teste, decisão que não está no código, erro que já se repetiu. Artefato, Design e Slides servem para mock, one-pager e apresentação. Mudança em `frontend/` e `backend/` é edição no repositório. O `/design-sync` é de design system React.

**Antigravity.** Rule é invariante. Skill é o passo a passo. Para o App e a CLI verem, ficam em `.agents/` no repo ou em `~/.gemini/config/`. Rule sem o frontmatter certo é ignorada. `/plan` antes de mexer em algo arriscado. `/goal` até a condição passar. `/boost` para um problema difícil e estreito. `/swarm` ou `/run-workflow` quando o trabalho se parte em arquivos. `/teamwork` só para campanha de dias.

## 5. Nuvem e agenda

| | Quando cabe | O que não vê |
|---|---|---|
| **Cursor**, Cloud Agent e Automations | Revisão e rotina do que já está no Bitbucket. O clone remoto inclui Bitbucket Cloud | Este Apache, a pasta home, `backend/Data`, `.env` |
| **Claude**, `/schedule` | Tarefa na infra da Anthropic, com o laptop fechado. O push de volta é para o GitHub | O XAMPP. Um bundle do Bitbucket não volta. No Windows, um `--cloud` sobe `.env` não commitado se o arquivo estiver rastreado |
| **Claude**, agenda do Desktop | Arquivos locais, inclusive não commitados | Só roda com o app aberto e o PC acordado |
| **Claude** e **Cursor**, `/loop` | Repetir o mesmo pedido de tempos em tempos, nesta conversa aberta. Exemplo: `/loop 5m veja se o deploy terminou` | Para quando a sessão fecha. O intervalo mínimo no Claude é 1 minuto. Disparo perdido não é recuperado |
| **Antigravity**, `/automation` | Horário fixo, na aba Automations. Conversa nova a cada vez, modelo Flash, sem memória da execução anterior | O fio da conversa em que você criou |
| **Antigravity**, `/schedule` | Acordar esta mesma conversa | Morre com ela, salvo daemon |
| **Antigravity**, Remote Agent | O que está no GitHub, com o PC dormindo | Arquivos desta máquina, MCP e skill instalados aqui. Não devolve para o Bitbucket |

`/loop` é um despertador dentro da conversa aberta. A cada intervalo, o mesmo pedido roda de novo: olhar um deploy, um log, uma fila. A sessão precisa estar aberta e ociosa. Fechar a janela para o relógio.

`/goal` é outra coisa: segue trabalhando, turno após turno, até uma condição ficar provada ("os testes passam"). Não espera relógio.

`/schedule` no Claude e `/automation` no Antigravity rodam num horário mesmo com esta conversa fechada. No Claude, isso é na nuvem e não vê o XAMPP. No Antigravity, cada horário abre uma conversa nova.

## 6. Tarefa normal

1. **Mapa.** `graphify` antes de vasculhar. Depois de mexer, `graphify update .`.
2. **Afiar, se ainda está cru.** `/grill-me`. Uma pergunta por vez, com resposta recomendada. O que ficar decidido vai para `.scratch/<assunto>/`.
3. **Plano, se a mudança é grande.** Modo Plan no Cursor (Shift+Tab), `/plan` no Claude e no Antigravity. Mudança pequena pula.
4. **Menos código.** `/ponytail` ao implementar. `lite` avisa a opção menor. `full` é o padrão. `ultra` questiona o pedido antes de fazer. Para com "stop ponytail".
5. **Fazer.** Na pasta da conversa, com o endereço `http://127.0.0.1/crm-.../login`. Teste primeiro: `tdd`. Seguir até provar o fim: `/goal` com condição medível ("os testes de auth passam").
6. **Tela.** Se mudou o que a pessoa vê, o navegador é obrigatório. Seção 7. Prompt "Conferir a tela".
7. **Revisar.** `code-review` nos padrões do repo e no que foi combinado. A spec sai de `.scratch/`. `/ponytail-review` no excesso de código.
8. **Conversa.** Seção 2. Esvaziar, encurtar ou passar com `/handoff`.

## 7. Navegador

Toda mudança visual passa por aqui. Print solto no chat não conta como conferido.

| Onde | O que usar em toda ida à página |
|---|---|
| **Antigravity** | Chrome DevTools (`chrome-devtools`) junto com `/browser`. Cada chamada abre a página de verdade, lê o console e a rede, clica no fluxo e tira print. É o caminho do CRM neste app |
| **Cursor** | O browser do agente: abre, clica, lê console e rede, tira print. No ajuste fino, o modo Design deixa você clicar no elemento |
| **Claude** | `built-in-browser` no localhost. `chrome-browser` quando a página precisa do seu Chrome logado |

Desktop e celular. Se o frontend mudou, o `pnpm build` da pasta da conversa entra antes de olhar de novo.

No Antigravity, as outras skills do mesmo plugin entram quando o problema é esse: `troubleshooting` se o DevTools não conecta, `cookie-debugging` se o login cai, `debug-optimize-lcp` se a página demora a aparecer, `a11y-debugging` em foco e contraste, `memory-leak-debugging` se a memória sobe.

## 8. Prompts por situação

Não há skill que reescreva o prompt antes de enviar. Cole o texto da situação. Troque o endereço pela pasta da conversa.

### Fora da tela

**Ideia crua** — ainda tem decisão em aberto.

```
/grill-me
Quero [o que]. Ainda não fechei [a dúvida]. Pergunte uma de cada vez, com uma resposta recomendada, até a gente concordar. Não codifique ainda.
```

**Mudança grande** — vale um plano antes de mexer.

```
/plan
[O que precisa existir.] Pesquise o código com o graphify, me entreviste se faltar decisão e escreva o plano. Não altere arquivo até eu aprovar.
```

**Tarefa de código** — regra, dado, endpoint ou bug que não é visual.

```
[O que está errado ou o que deve passar a acontecer.]

Consulte o graphify antes de vasculhar. Implemente na pasta desta conversa, com /ponytail, teste primeiro no arquivo mexido e me mande http://127.0.0.1/crm-.../login com o que clicar. Não commite.
```

**Seguir até provar** — o fim é medível e você não quer confirmar cada passo.

```
/goal [condição, por exemplo: os testes de auth passam]
Comece agora. Só encerre quando essa condição estiver provada no que rodou.
```

**PRD** — a conversa já decidiu a regra e você quer o documento. O grill-me vem antes, se ainda houver decisão aberta.

```
/to-spec
Transforme o que já combinamos num spec e grave em .scratch/<assunto>/spec.md. Sem entrevista nova e sem outro tracker. Não codifique.
```

**Fatiar** — o spec está grande.

```
/to-tickets
Quebre o spec em tickets. Um arquivo por ticket em .scratch/<assunto>/issues/, numerado a partir de 01, bloqueador primeiro. Cada um diz por quem está bloqueado. Não codifique.
```

**Revisar** — o código já está escrito.

```
Revise desde a main: /code-review nos padrões do repo e no que combinamos, e /ponytail-review no excesso. A spec está em .scratch/. Só relatório. Não altere e não commite.
```

**Esvaziar o Claude** — a próxima tarefa não usa o que foi dito.

```
/clear [nome-da-que-fica]
```

**Passar a conversa** — outra sessão continua.

```
/handoff
Resuma o que foi decidido, o que já está feito e o que falta, num documento para a próxima sessão.
```

### Pasta e junção

**Abrir a pasta** — a feature vai virar código e tela. A conversa que ainda é só decisão não usa este prompt.

```
Abra a worktree desta feature em C:\xampp\htdocs\crm-[assunto], no branch feat/[assunto], como o AGENTS.md §12. A pasta principal fica na main. Não use a worktree escondida do Cursor nem do Claude.

Quando a pasta abrir, me mande http://127.0.0.1/crm-[assunto]/login e o que clicar.
```

**Atualizar a feature** — a main andou e a pasta da feature precisa acompanhá-la.

```
Na pasta C:\xampp\htdocs\crm-[assunto], traga a main para este branch. Resolva o conflito aqui. Rode o teste do arquivo mexido. Se a tela mudou, rode o build e confira em http://127.0.0.1/crm-[assunto]/, no desktop e no celular.

Não junte na pasta principal e não envie para o origin.
```

**Juntar na main local** — a feature já foi conferida na pasta dela. Uma branch por vez.

```
Junte o branch feat/[assunto] na main da pasta C:\xampp\htdocs\crm-tracken. Se sobrar conflito, resolva nesta junção. Confira a tela em http://127.0.0.1/crm-tracken/.

Não rode a suíte inteira ainda e não envie para o origin.
```

**Validar a main** — a main local está do jeito que vai sair. Uma vez só.

```
Na pasta C:\xampp\htdocs\crm-tracken, na main, rode composer test, composer analyse, pnpm typecheck e pnpm test:unit. Se o frontend mudou, pnpm build. Me diga o que falhou.

Não envie para o origin.
```

**Publicar** — a suíte da main passou. Este prompt é o pedido de envio.

```
Envie a main local para origin/main. Não force. Me diga o commit que ficou publicado.
```

**Pacote de produção** — o commit já está em origin/main.

```
Monte o pacote com build_manual_release.ps1 a partir do commit que está em origin/main. Não envie ao servidor.
```

### Na tela

**Conferir a tela** — depois de implementar, ou para ver o estado atual.

```
Abra http://127.0.0.1/crm-.../login e vá até a tela desta tarefa. No Antigravity use o Chrome DevTools em toda chamada de navegador: página, console e rede. No Cursor use o browser do agente. No Claude use o navegador interno.

Percorra o fluxo que mudou, no desktop e no celular. Traga o que quebrou, o que a rede devolveu e um print de cada largura. Se o frontend mudou, rode o build desta pasta antes.
```

**Corrigir a tela** — algo está errado no que se vê, ou a chamada falha.

```
Abra a tela real em http://127.0.0.1/crm-.../ com o Chrome DevTools no Antigravity (no Cursor, o browser do agente; no Claude, o navegador interno). Reproduza o problema clicando no fluxo. Leia o console e a rede antes de mexer no código.

Corrija a causa. Abra de novo, desktop e celular, e mostre o antes e o depois.
```

**Quatro ideias** — feature ou correção visual e o formato ainda não está claro. A base é a tela real. A skill `prototype` fica para dúvida de regra ou de estado.

```
Olhe a tela real em http://127.0.0.1/crm-.../ e as telas vizinhas do mesmo fluxo, pelo Chrome DevTools no Antigravity (browser do agente no Cursor, navegador interno no Claude). Salve PNG do estado atual com o Playwright, no desktop e no celular.

Depois gere 4 propostas em PNG, fiéis ao CRM: mesma casca (TrackenPageShell, TrackenPageHeader, Tracken*, Element Plus, tokens --tk-*, sidebar, barra mobile em 768px). As 4 diferem em layout, componente, cor e formato. Não entregue um HTML solto no lugar do PNG.

Pare e espere eu escolher.
```

**Implementar a escolhida** — depois que você apontou uma das quatro. Se a tarefa também tem regra, passe pelo `/grill-me` ou pelo Plan e grave o spec em `.scratch/<assunto>/spec.md` antes de codar.

```
A ideia escolhida é a [número], no PNG [caminho]. Implemente na pasta desta conversa.

O que muda: [o que você viu no PNG].
O que não muda: casca, fluxo e regras que eu não citei.
Arquivos: os da tela real, não um protótipo paralelo.

Quando terminar, confira no navegador (Chrome DevTools no Antigravity), desktop e celular, e me mande o endereço.
```

O print das ideias sai com o Playwright do projeto (`pnpm exec playwright screenshot`, na pasta da conversa).

## 9. Só quando precisar

| Situação | Use |
|---|---|
| A conversa já decidiu o quê, e você quer o documento | `/to-spec` **(manual)**. Grava em `.scratch/<assunto>/spec.md` |
| O documento está grande e precisa virar fatias | `/to-tickets` **(manual)**. Um arquivo por ticket em `.scratch/<assunto>/issues/` |
| Executar uma fatia ou um spec já fechado | `/implement` **(manual)**. Ele puxa `tdd` e `code-review`. No CRM, diga para não commitar: a skill commita sozinha |
| A dúvida é de regra ou de estado, não de visual | `prototype`. HTML descartável. Não usar para desenhar tela do CRM |
| Inchaço no projeto, só relatório | `/ponytail-audit`. Apagar ainda exige as 4 provas do `AGENTS.md` |
| Atalhos marcados com `shortcut:` | `/ponytail-debt` |
| Quanto código ou custo saiu | `/ponytail-gain` |
| Bug que não se explica lendo | Modo Debug no Cursor |
| Bug difícil, várias hipóteses | `/boost` no Antigravity. Plano pago |
| Trabalho que parte em pedaços | `/swarm` no Antigravity. No Cursor, `/multitask` na janela de agentes, se os pedaços não mexem nos mesmos arquivos |
| Campanha de dias | `/teamwork` no Antigravity. Plano pago |
| Olhar de tempos em tempos, com a conversa aberta | `/loop 5m ...` no Claude e no Cursor |
| Explicar com desenho, sem ser tela do produto | `/visualize` no Cursor. Artifacts no Claude. `/generative_ui` no Antigravity |
| Aprender um assunto, fora do sistema | `/teach` |
