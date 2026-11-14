# Guia das skills

O uso no dia a dia, em ordem, está em `COMO-USAR.md`. Este arquivo é o catálogo.

- **ai-brain** (`~/ai-brain/skills`, 78 skills): as mesmas no Claude Code, no Cursor e no Antigravity (os três apontam para essa pasta).
- **Antigravity**: tem 12 skills embutidas a mais (seção 9).
- **Chamar:** `/nome` no Claude e no Antigravity. As marcadas com **(manual)** só rodam assim; as outras o agente também carrega sozinho pela descrição.
- **No CRM:** o `AGENTS.md` ganha de qualquer skill (commit só quando pedir, teste só do arquivo na branch).

---

## 1. Fluxo de desenvolvimento

Ordem: `graphify` → `grill-me` → (`prototype`) → `to-spec` → `to-tickets` → `implement` (+ `tdd`) → `code-review` → `handoff` se a conversa ficar longa.

| Skill | Função | Quando usar |
|---|---|---|
| `graphify` | Gera o mapa do código (grafo) e responde perguntas por ele | Antes de vasculhar o projeto; `graphify update .` depois de mexer no código |
| `grill-me` **(manual)** | Entrevista dura para afiar plano ou design. Chama a skill `grilling` | Ideia ainda crua. O que ficar decidido segue para `.scratch/<assunto>/` |
| `prototype` | Protótipo descartável de lógica ou de estado, em HTML | Dúvida se a regra faz sentido. Tela do CRM não usa este HTML: o visual vai em PNG, no `COMO-USAR.md` |
| `to-spec` **(manual)** | Transforma a conversa em spec, sem nova entrevista | Assunto já discutido. Grava em `.scratch/<assunto>/spec.md` |
| `to-tickets` **(manual)** | Quebra plano ou spec em tickets verticais com dependências | Um arquivo por ticket em `.scratch/<assunto>/issues/`, a partir de `01`, bloqueador primeiro |
| `implement` **(manual)** | Implementa spec ou ticket usando `tdd` e `code-review` | Executar um ticket. ⚠️ Commita sozinho: no CRM, mandar não commitar |
| `tdd` | Ciclo vermelho → verde, um teste por vez | Feature ou bug com teste primeiro |
| `code-review` | Revisão em duas frentes: padrões do repo e aderência ao spec | "Revisa desde a main" |
| `handoff` **(manual)** | Resume a conversa num documento para outra sessão continuar | Antes de trocar de conversa |
| `fdd-tracken` | Task do MeisterTask → validação → FDD enxuto | Planejar ou documentar demanda TRACKen |
| `teach` **(manual)** | Curso em várias sessões (lições HTML, registros) | Aprender um assunto. Rodar numa pasta própria |

As issues do CRM ficam em `.scratch/<assunto>/issues/<NN>-<slug>.md` (já é assim em `fluxo-unico` e `solicitacoes-tarefas`). O `code-review` lê o caminho em `docs/agents/issue-tracker.md`. Não peça outro tracker.

## 2. Documentos e arquivos

| Skill | Função | Quando usar |
|---|---|---|
| `docs` | Documento editável e compartilhável | Qualquer documento sem formato definido |
| `docx` | Cria e edita Word | Pediu .docx ou recebeu um |
| `pdf` | Lê, junta, divide, preenche, faz OCR em PDF | Qualquer coisa com PDF |
| `xlsx` | Cria e edita planilha (.xlsx, .csv) | Planilha como entrada ou saída |
| `pptx` | Cria e edita PowerPoint | Pediu .pptx ou recebeu um |
| `google-workspace` | Cria e altera Docs, Sheets e Slides no Drive | Arquivo do Google |

## 3. Navegador e computador

| Skill | Função | Quando usar |
|---|---|---|
| `chrome-browser` | Usa o seu Chrome real, com seus logins | Site que precisa da sua conta |
| `built-in-browser` | Usa o navegador interno do app do Claude | Localhost, telas do CRM, páginas sem login |
| `computer-use` | Controla apps do computador por print e clique | Tarefa fora do navegador |

## 4. Pesquisa e utilidades

| Skill | Função | Quando usar |
|---|---|---|
| `deep-research` | Pesquisa em várias fontes e entrega relatório | Comparar opções, mercado, estado da arte |
| `skill-creator` | Cria, melhora e testa skills | Skill nova: salvar em `~/ai-brain/skills/` e rodar `~/ai-brain/install.sh` |
| `import-memory` | Importa memória exportada de outro assistente | Trazer contexto do ChatGPT/Gemini |
| `morning` | Resumo da manhã em página | `/morning` |

## 5. Vite

| Skill | Função | Quando usar |
|---|---|---|
| `vite` | Configuração e build do Vite | Mexer no Vite como ferramenta |

## 6. OmniRoute: API e MCP (`omni-*`, 23)

OmniRoute é o roteador de LLM (um endpoint, vários provedores). `omni-*` = pela API REST/MCP. `cli-*` (seção 7) = pelo terminal.

| Skill | Função | Quando usar |
|---|---|---|
| `omni-auth` | Login, token Bearer, sessão | Começar aqui: autenticar na API |
| `omni-api-keys` | Cria, gira e revoga chaves; escopo, limite, validade | Dar acesso a um app ou agente |
| `omni-providers` | Conecta e testa provedores (OpenAI, Anthropic etc.) | Adicionar ou trocar provedor |
| `omni-models` | Lista modelos e aliases | Saber que modelo está disponível |
| `omni-inference` | Chat, embeddings, imagem, áudio, rerank | Usar o OmniRoute como API compatível com OpenAI |
| `omni-combos-routing` | Combos com 19 estratégias e fallback | Definir qual modelo atende e o reserva |
| `omni-budget` | Limite de gasto, cota de tokens, rate limit | Controlar custo |
| `omni-usage-logs` | Logs de chamada, custo e tokens | Ver quanto gastou e onde |
| `omni-cache` | Cache de respostas (TTL, semântico) | Economizar em pedidos repetidos |
| `omni-compression` | Compressão RTK (saída de comando) e Caveman (texto) | Cortar 60 a 90% de tokens |
| `omni-context-rtk` | Filtros RTK e regras de contexto | Ajustar o que entra no contexto |
| `omni-resilience` | Saúde, circuit breaker, latência, alertas | Provedor falhando ou lento |
| `omni-proxies` | Proxy HTTP/SOCKS por provedor | Rede que exige proxy |
| `omni-tunnels` | Túnel ngrok/Cloudflare | Expor o OmniRoute para fora |
| `omni-settings` | Config global (system prompt, filtros de IP, login) | Mudar comportamento padrão |
| `omni-webhooks` | Webhooks de eventos (falha, cota estourada) | Ser avisado de eventos |
| `omni-db-backups` | Backup e restauração do banco SQLite | Antes de mexer pesado ou migrar |
| `omni-sync-cloud` | Sincroniza config com a nuvem | Mesma config em outra máquina |
| `omni-mcp` | Conecta ao MCP do OmniRoute (110 ferramentas) | Agente usando o OmniRoute por MCP |
| `omni-agents-a2a` | Protocolo agente-para-agente (JSON-RPC) | Agente consultando roteamento, cota, custo |
| `omni-cli-tools` | Integrações de CLI expostas pela API | Plugar ferramenta de linha de comando |
| `omni-version-manager` | Instala e atualiza serviços embutidos (9Router, CLIProxyAPI) | Atualizar ou reiniciar esses serviços |
| `omni-github-skills` | Busca, pontua e instala skills do GitHub | Achar skill da comunidade. ⚠️ Revisar antes de instalar |

## 7. OmniRoute: terminal (`cli-*`, 21)

| Skill | Função | Quando usar |
|---|---|---|
| `cli-setup` | Instalação inicial, config, variáveis, autostart | Primeira vez numa máquina |
| `cli-serve` | Liga, para e reinicia o servidor | Subir o OmniRoute |
| `cli-health` | Status e painel ao vivo | Conferir se está tudo de pé |
| `cli-providers` | Adiciona, testa e gira chave de provedor | Mesmo que `omni-providers`, pelo terminal |
| `cli-keys` | Chaves de API e OAuth | Mesmo que `omni-api-keys`, pelo terminal |
| `cli-models` | Catálogo e aliases | Mesmo que `omni-models`, pelo terminal |
| `cli-routing` | Combos e fallback | Mesmo que `omni-combos-routing`, pelo terminal |
| `cli-chat` | Chat e REPL interativo | Testar um modelo rápido |
| `cli-batches` | Jobs em lote | Processar muitos pedidos de uma vez |
| `cli-eval` | Benchmarks e comparação de modelos | Escolher o melhor modelo para uma tarefa |
| `cli-cost-usage` | Custo e uso por provedor/período | Relatório de gasto |
| `cli-compression` | Testa compressão RTK/Caveman | Ver quanto economiza num prompt real |
| `cli-contexts` | Configs de contexto e sessões | Ajustar pipeline de contexto |
| `cli-resilience` | Destrava provedor preso, cooldowns | Provedor bloqueado |
| `cli-tunnel` | Túneis | Expor para fora pelo terminal |
| `cli-backup-sync` | Backup e restauração | Snapshot antes de mudança |
| `cli-mcp` | Status e ferramentas do MCP | Depurar o MCP |
| `cli-a2a` | Testa o servidor A2A | Depurar agente-para-agente |
| `cli-plugins-skills` | Skills, plugins e memória do OmniRoute | Gerenciar extensões do OmniRoute |
| `cli-policy-audit` | Logs de auditoria e políticas de acesso | Investigar quem fez o quê |
| `cli-skill-collector` | Detecta seus agentes e instala skills do GitHub neles | ⚠️ Revisar antes de instalar |

## 8. Só no Claude (embutidas, não estão no ai-brain)

| Skill | Função | Quando usar |
|---|---|---|
| `simplify` | Revisa o código alterado e aplica simplificações | Depois de implementar |
| `security-review` | Revisão de segurança das mudanças | Antes de integrar algo sensível |
| `run` | Sobe o app e confere a mudança funcionando | Ver na tela, não só no teste |
| `init` | Gera o CLAUDE.md de um projeto | Projeto novo |
| `loop` | Repete um comando em intervalo | Acompanhar algo de tempos em tempos |
| `schedule` | Agente agendado na nuvem | Tarefa recorrente ou num horário |
| `dataviz` | Padrão para gráficos e dashboards | Qualquer gráfico |
| `fewer-permission-prompts` | Libera comandos de leitura frequentes | Muitos pedidos de permissão |
| `update-config` | Mexe em settings.json, hooks, permissões | "Sempre que X, faça Y" |
| `consolidate-memory` | Organiza a memória do Claude | Memória bagunçada ou repetida |
| `neon:*` (plugin) | Postgres na Neon | Precisa autorizar em `/mcp` |

## 9. Só no Antigravity (embutidas)

| Skill | Função | Quando usar |
|---|---|---|
| `antigravity-guide` | Manual do Antigravity, CLI `agy`, atalhos | Dúvida de uso |
| `agy-customizations` | Como criar skills, rules, hooks, MCP lá | Personalizar o Antigravity |
| `automation` | Tarefa agendada recorrente | `/automation` |
| `swarm` | Vários agentes em paralelo num quadro | Trabalho que divide em partes. ⚠️ Gasta muita cota |
| `run-workflow` | Script Python que orquestra vários agentes | Espalhar trabalho por muitos arquivos e juntar |
| `generative_ui` | Widget ou diagrama interativo no chat | Mostrar algo visual |
| `plugin` | Instala, ativa ou cria plugin | Empacotar skills + rules + MCP |
| `migrate-agent-settings` | Traz config do Claude ou do Cursor | Migrar setup |
| `migrate-workflows` | Converte workflows antigos em skills | Limpar workflows legados |
| `permissioned-github` | Regras de GitHub com permissão | Agente bloqueado no GitHub |
| `ui-plugin-navigation` | Abre painel de plugin | Plugin com painel |
| `swarm_monitor` / `swarm_narrator` | Internas do swarm | Não chamar |

Também no Antigravity: workflow `/graphify` e rule `graphify` em `.agents/` do CRM. Plugins: `chrome-devtools-plugin`, `swarm`. As skills do Chrome DevTools estão na seção 11.

## 10. Ponytail

Força a solução mais simples que funciona: YAGNI, biblioteca padrão antes de código próprio, recurso nativo antes de dependência. Estão no ai-brain. A cola é este guia.

| Skill | Função | Quando usar |
|---|---|---|
| `ponytail` | Modo "preguiçoso": a menor mudança que resolve tudo. Vale para a sessão inteira. Níveis `lite`, `full` (padrão), `ultra`. Para com "stop ponytail" | Qualquer tarefa de código com risco de exagero |
| `ponytail-audit` | Auditoria do repositório inteiro: bugs, segurança, carga real, código arriscado sem teste, lentidão e o que apagar, juntar ou dividir. Em ordem de gravidade | Revisão geral do projeto. Só relatório, não altera |
| `ponytail-review` | Revisão de uma mudança: lógica, segurança, carga, teste, desempenho e excesso de código. Lê o código ligado ao diff, não só ele | Depois de implementar, junto com o `code-review` |
| `ponytail-debt` | Lista os comentários `shortcut:` (e os antigos `ponytail:`) como livro de dívidas | Ver os atalhos deixados para depois |
| `ponytail-gain` | Placar de economia (código, custo, tempo) | Curiosidade |

No CRM, `ponytail-audit` combina com o `AGENTS.md` §6: o relatório lista suspeitos, mas remover exige as 4 provas.

## 11. Comandos das plataformas

Não estão no ai-brain de propósito. São modos e atalhos do aplicativo. O mesmo nome muda um pouco de um para o outro. No CRM, o `AGENTS.md` continua valendo: nenhum desses autoriza commit nem a suíte inteira de testes.

### Continuar até acabar: goal

Você descreve o fim. O agente segue sozinho entre uma mensagem e outra, até esse fim estar provado.

| Onde | Como para |
|---|---|
| **Cursor** `/goal objetivo` | Só marca concluído quando a evidência atual prova cada ponto. Sem prazo. "A cada 5 min" é `/loop`, não goal |
| **Claude** `/goal condição` | Outro modelo lê a conversa no fim de cada turno e decide se a condição foi cumprida. `/goal` sem texto mostra o status. `/goal clear` tira |
| **Antigravity** `/goal objetivo` | Roda build, acha o erro e corrige sem esperar você confirmar cada passo |

Condição boa: um fim medível ("os testes de auth passam") e como provar. Condição ruim: "melhora o código".

### Plano antes de mexer

As três têm. Serve quando a mudança é grande ou ainda tem decisão em aberto. Mudança pequena vai direto no agente.

| Onde | O que acontece |
|---|---|
| **Cursor**, modo Plan (Shift+Tab) | Pesquisa o código, pergunta, escreve o plano. Você aprova, aí ele constrói |
| **Claude** `/plan` | Entra no modo plano antes de alterar |
| **Antigravity** `/plan` | Pesquisa, entrevista, gera um artefato de plano. Você comenta ou aprova, aí ele executa |

### Vários agentes (Antigravity)

| Comando | Quando | Cuidado |
|---|---|---|
| `/boost` | Bug difícil, condição de corrida, algoritmo. Vários agentes testam hipóteses e um verifica | Plano pago. Segundos a horas |
| `/teamwork` | Campanha grande: migração, pesquisa de dias. Começa com entrevista e um plano que prende o escopo | Plano pago. Horas a dias |
| `/swarm` | A tarefa parte em pedaços independentes. Workers nomeados e um verificador, num quadro | Gasta muita cota. Já na seção 9 |

### Modos do Cursor

Shift+Tab troca. O seletor fica no painel do agente.

| Modo | Faz |
|---|---|
| **Agent** | O padrão. Edita, roda comando, corrige |
| **Ask** | Só lê e explica. Não altera arquivo |
| **Plan** | Plano para você aprovar antes de construir |
| **Debug** | Bug que não se explica lendo o código. Instrumenta, olha log, print e saída de verdade, aí corrige |
| **Design** | No navegador da janela de agentes. Você clica no elemento (ou desenha em cima) e o agente mexe no código daquilo |

### Navegador

| Onde | Faz |
|---|---|
| **Cursor**, browser | Abre página, clica, preenche, lê console e rede, tira print. É o que confere a tela do CRM |
| **Claude** | `built-in-browser` (localhost) e `chrome-browser` (seu Chrome logado). Seção 3 |
| **Antigravity** | Chrome DevTools (`chrome-devtools`) em toda chamada de navegador, junto com `/browser`. Página, console, rede, clique e print. É o caminho do CRM neste app |

### Chrome DevTools (plugin do Antigravity)

`chrome-devtools` entra em toda ida à página. As outras cinco skills do `chrome-devtools-plugin` entram quando o problema é o da linha.

| Skill | Quando |
|---|---|
| `chrome-devtools` | Toda chamada de navegador: abrir, clicar, console, rede, performance |
| `troubleshooting` | O DevTools não conecta, ou `list_pages` / `navigate_page` falha |
| `memory-leak-debugging` | Memória subindo, tela travando, snapshot de heap. Não lê o arquivo cru: passa pelo memlab |
| `debug-optimize-lcp` | Página lenta para mostrar o conteúdo principal |
| `a11y-debugging` | Teclado, foco, contraste, rótulo de acessibilidade |
| `cookie-debugging` | Login caindo, 401/403, cookie de sessão |

### Ver na conversa, sem virar arquivo do projeto

| Onde | Faz |
|---|---|
| **Cursor** `/visualize` | Gráfico, tabela ou diagrama dentro do chat |
| **Cursor**, canvas | Painel React ao lado do chat, para resultado que você quer rever (auditoria, números, tabela grande) |
| **Claude**, artifacts | Página ou app ao lado do chat. `/artifacts` lista os seus. `/design` monta telas. `/slides` monta apresentação |
| **Antigravity** `/generative_ui` | Diagrama ou widget clicável no painel lateral |

### Agenda e repetição

| Onde | Faz |
|---|---|
| **Claude** `/schedule` | Tarefa na nuvem, num horário. Já na seção 8. `/loop` repete nesta conversa |
| **Cursor** `/loop 5m ...` | Repete um pedido nesta conversa, num intervalo |
| **Cursor**, automate | Automação do Cursor (abre o editor de automações). Só na janela de agentes |
| **Antigravity** `/schedule` | Uma vez, ou cron, em segundo plano |
| **Antigravity** `/automation` | Automação fixa, ligada na aba Automations. Já na seção 9 |

### Compactar a conversa

| Onde | Faz |
|---|---|
| **Claude** `/compact` | Resume o que já foi dito e libera espaço. Dá para passar um foco: `/compact mantém as decisões do plano`. `/clear` zera e começa outra |
| **Cursor** e **Antigravity** | Não achei um comando `/compact`. Conversas longas o próprio app resume quando o contexto enche |
