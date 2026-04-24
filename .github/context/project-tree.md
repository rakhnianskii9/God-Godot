# Project Tree Snapshot

- Generated: 2026-04-16T09:03:31+00:00
- Root: /home/projects/new-flowise
- Max depth: 4
- Exclusions: node_modules/.git/.flowise, build artifacts, archives, tmp/export zones, env files

```text
new-flowise
├── .github/
│   ├── .githooks/
│   │   └── pre-push
│   ├── agents/
│   │   ├── .gitignore
│   │   ├── AGENTS.md
│   │   ├── Code-review-subagent.agent.md
│   │   ├── Conductor.agent.md
│   │   ├── Consilium-Boss.agent.md
│   │   ├── Consilium-Codex.agent.md
│   │   ├── Consilium-Devil-Gemini.agent.md
│   │   ├── Consilium-Devil-GPT.agent.md
│   │   ├── Consilium-Devil-Sonnet.agent.md
│   │   ├── Consilium-Devil.agent.md
│   │   ├── Consilium-Gemini.agent.md
│   │   ├── Consilium-Opus.agent.md
│   │   ├── Consilium-Sonnet.agent.md
│   │   ├── Implement-subagent.agent.md
│   │   ├── Planning-subagent.agent.md
│   │   ├── Proscons-devils-advocate.agent.md
│   │   ├── Security-Auth.agent.md
│   │   ├── Security-Boss.agent.md
│   │   ├── Security-Infra.agent.md
│   │   ├── Security-Injection.agent.md
│   │   ├── Security-Web.agent.md
│   │   └── UI-Governor.agent.md
│   ├── bin/
│   │   ├── start-scorecard-loop
│   │   └── update-ide
│   ├── context/
│   │   ├── .last-update-ide.txt
│   │   ├── db-schema.json
│   │   ├── dynamic-conditions.json
│   │   ├── entities.json
│   │   ├── migrations.json
│   │   └── project-tree.md
│   ├── hooks/
│   │   ├── hooks.json
│   │   ├── posttool-quality.sh
│   │   ├── posttool-security.sh
│   │   └── pretool-guard.sh
│   ├── instructions/
│   │   ├── code-rules.instructions.md
│   │   └── copilot-instructions.md
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml
│   │   └── feature_request.yml
│   ├── mcp/
│   │   ├── config/
│   │   │   └── mcp.json
│   │   ├── data/
│   │   │   └── sqlite_vec.db
│   │   ├── output/
│   │   │   ├── aggregated.json
│   │   │   └── aggregator.pid
│   │   ├── venv-memory/
│   │   │   ├── bin/
│   │   │   └── lib/
│   │   └── memory.jsonl
│   ├── prompts/
│   │   ├── comit.md
│   │   └── diagnostique.prompt.md
│   ├── skills/
│   │   ├── docker-diagnostics/
│   │   │   └── SKILL.md
│   │   ├── facebook-observability-lab/
│   │   │   ├── scripts/
│   │   │   ├── templates/
│   │   │   └── SKILL.md
│   │   ├── fb-front-datetime-timezone/
│   │   │   └── SKILL.md
│   │   ├── fb-front-design-system-builder/
│   │   │   └── SKILL.md
│   │   ├── fb-front-react-practices/
│   │   │   └── SKILL.md
│   │   ├── fb-front-theme-darkmode/
│   │   │   └── SKILL.md
│   │   ├── fb-front-ui-consistency/
│   │   │   └── SKILL.md
│   │   ├── feature-dev/
│   │   │   └── SKILL.md
│   │   ├── octocode-code-forensics/
│   │   │   └── SKILL.md
│   │   ├── orchestration-qa/
│   │   │   └── SKILL.md
│   │   ├── playwright-ui-evidence/
│   │   │   └── SKILL.md
│   │   ├── pr-review-toolkit/
│   │   │   └── SKILL.md
│   │   ├── security-guidance/
│   │   │   └── SKILL.md
│   │   └── web-artifacts-builder/
│   │       ├── scripts/
│   │       └── SKILL.md
│   ├── workflows/
│   │   ├── docker-image-dockerhub.yml
│   │   ├── docker-image-ecr.yml
│   │   ├── main.yml
│   │   └── test_docker_build.yml
│   ├── FUNDING.yml
│   ├── lite-models.md
│   ├── lite-models.md.bak
│   ├── multiagents.md
│   ├── tasks.md
│   └── top-models.md
├── docker/
│   ├── scripts/
│   │   └── provision-first-party-collector-bridge.sh
│   ├── worker/
│   │   ├── healthcheck/
│   │   │   ├── healthcheck.js
│   │   │   └── package.json
│   │   ├── .env.example
│   │   ├── docker-compose.yml
│   │   ├── Dockerfile
│   │   └── README.md
│   ├── docker-compose-queue-prebuilt.yml
│   ├── docker-compose-queue-source.dev.yml
│   ├── docker-compose-queue-source.yml
│   ├── docker-compose.yml
│   └── Dockerfile
├── docs/
│   ├── about-project/
│   │   ├── agent-flow.png
│   │   ├── arriwa-description.md
│   │   ├── arriwa-technical-v2.md
│   │   └── chat-flow.png
│   ├── different-stuff/
│   │   ├── old/
│   │   │   ├── arriwa-technical-inputs.md
│   │   │   ├── arriwa-technical-v1.md
│   │   │   ├── sub_flow.md
│   │   │   └── whatsapp-api-media-limits.md
│   │   ├── cloud-backup-module.md
│   │   ├── token-save-policy.md
│   │   └── wa-types-message.md
│   ├── incoming-webhooks/
│   │   └── webhook-payload-specification.md
│   ├── moduls/
│   │   ├── CAPI-GTM/
│   │   │   ├── CAPI-GTM-ideal-prompt-template.md
│   │   │   └── CAPI-GTM-Module.md
│   │   ├── ActivityCorrelation.md
│   │   ├── Facebook.md
│   │   ├── rkx-domains.md
│   │   ├── rkx-orchestrator-deep-dive.md
│   │   └── Whatsapp-Gupshup.md
│   ├── subscriber/
│   │   └── exact-subscriber-data-structure-v2.md
│   └── tenant/
│       ├── exact-tenant-data-structure.md
│       └── first-facebook-login.md
├── metrics/
│   ├── grafana/
│   │   ├── grafana.dashboard.app.json.txt
│   │   └── grafana.dashboard.server.json.txt
│   ├── otel/
│   │   ├── compose.yaml
│   │   └── otel.config.yml
│   └── prometheus/
│       └── prometheus.config.yml
├── nginx/
│   ├── conf.d/
│   │   ├── default.conf
│   │   ├── gupshup-ip-whitelist.conf
│   │   └── gzip.conf
│   ├── modules/
│   ├── scripts/
│   │   ├── monitor-collector.sh
│   │   ├── provision-first-party-collector.sh
│   │   ├── setup-collector-nginx.sh
│   │   └── test-pixel-endpoints.sh
│   ├── sites-available/
│   │   ├── agency.rakhnianskii.com.conf
│   │   ├── collector.diveradent.com.conf
│   │   ├── collector.rakhnianskii.com.conf
│   │   ├── dev.rakhnianskii.com.conf
│   │   ├── dev.rakhnianskii.com.conf.full
│   │   ├── flows.rakhnianskii.com.conf
│   │   ├── rakhnianskii.com.conf
│   │   └── rkx.domains.conf
│   ├── sites-enabled/
│   │   ├── agency.rakhnianskii.com.conf
│   │   ├── collector.diveradent.com.conf
│   │   ├── collector.rakhnianskii.com.conf
│   │   ├── dev.rakhnianskii.com.conf
│   │   ├── flows.rakhnianskii.com.conf
│   │   ├── rakhnianskii.com.conf
│   │   └── rkx.domains.conf
│   ├── www/
│   │   ├── rakhnianskii.com/
│   │   │   ├── favicon.ico
│   │   │   ├── index.html
│   │   │   └── без фона.png
│   │   └── shared/
│   │       └── rakhnianskii-favicon.ico
│   ├── dhparams.pem
│   ├── fastcgi_params
│   ├── mime.types
│   ├── nginx.conf
│   ├── nginx.conf.backup
│   ├── nginx.conf.dpkg-dist
│   ├── README.md
│   ├── scgi_params
│   ├── upstreams.conf
│   └── uwsgi_params
├── packages/
│   ├── api-documentation/
│   │   ├── src/
│   │   │   ├── configs/
│   │   │   ├── yml/
│   │   │   └── index.ts
│   │   ├── nodemon.json
│   │   ├── package.json
│   │   ├── README-ZH.md
│   │   ├── README.md
│   │   └── tsconfig.json
│   ├── components/
│   │   ├── credentials/
│   │   │   ├── AgentflowApi.credential.ts
│   │   │   ├── AirtableApi.credential.ts
│   │   │   ├── AlibabaApi.credential.ts
│   │   │   ├── AnthropicApi.credential.ts
│   │   │   ├── ApifyApi.credential.ts
│   │   │   ├── ArizeApi.credential.ts
│   │   │   ├── AssemblyAI.credential.ts
│   │   │   ├── AstraApi.credential.ts
│   │   │   ├── AWSCredential.credential.ts
│   │   │   ├── AzureCognitiveServices.credential.ts
│   │   │   ├── AzureOpenAIApi.credential.ts
│   │   │   ├── BaiduApi.credential.ts
│   │   │   ├── BraveSearchApi.credential.ts
│   │   │   ├── CerebrasApi.credential.ts
│   │   │   ├── ChatflowApi.credential.ts
│   │   │   ├── ChromaApi.credential.ts
│   │   │   ├── CohereApi.credential.ts
│   │   │   ├── CometApi.credential.ts
│   │   │   ├── ComposioApi.credential.ts
│   │   │   ├── ConfluenceCloudApi.credential.ts
│   │   │   ├── ConfluenceServerDCApi.credential.ts
│   │   │   ├── CouchbaseApi.credential.ts
│   │   │   ├── DeepseekApi.credential.ts
│   │   │   ├── DynamodbMemoryApi.credential.ts
│   │   │   ├── E2B.credential.ts
│   │   │   ├── ElasticsearchAPI.credential.ts
│   │   │   ├── ElectricsearchUserPassword.credential.ts
│   │   │   ├── ElevenLabsApi.credential.ts
│   │   │   ├── ExaSearchApi.credential.ts
│   │   │   ├── FacebookMarketingOAuth2.credential.ts
│   │   │   ├── FigmaApi.credential.ts
│   │   │   ├── FireCrawlApi.credential.ts
│   │   │   ├── FireworksApi.credential.ts
│   │   │   ├── GithubApi.credential.ts
│   │   │   ├── GmailOAuth2.credential.ts
│   │   │   ├── GoogleAuth.credential.ts
│   │   │   ├── GoogleCalendarOAuth2.credential.ts
│   │   │   ├── GoogleDocsOAuth2.credential.ts
│   │   │   ├── GoogleDriveOAuth2.credential.ts
│   │   │   ├── GoogleGenerativeAI.credential.ts
│   │   │   ├── GoogleMakerSuite.credential.ts
│   │   │   ├── GoogleSearchApi.credential.ts
│   │   │   ├── GoogleSheetsOAuth2.credential.ts
│   │   │   ├── GroqApi.credential.ts
│   │   │   ├── HTTPApiKey.credential.ts
│   │   │   ├── HTTPBasicAuth.credential.ts
│   │   │   ├── HTTPBearerToken.credential.ts
│   │   │   ├── HuggingFaceApi.credential.ts
│   │   │   ├── IBMWatsonx.credential.ts
│   │   │   ├── JinaApi.credential.ts
│   │   │   ├── JiraApi.credential.ts
│   │   │   ├── LangfuseApi.credential.ts
│   │   │   ├── LangsmithApi.credential.ts
│   │   │   ├── LangWatchApi.credential.ts
│   │   │   ├── LitellmApi.credential.ts
│   │   │   ├── LocalAIApi.credential.ts
│   │   │   ├── LunaryApi.credential.ts
│   │   │   ├── MeilisearchApi.credential.ts
│   │   │   ├── Mem0MemoryApi.credential.ts
│   │   │   ├── MicrosoftOutlookOAuth2.credential.ts
│   │   │   ├── MicrosoftTeamsOAuth2.credential.ts
│   │   │   ├── MilvusAuth.credential.ts
│   │   │   ├── MistralApi.credential.ts
│   │   │   ├── MomentoCacheApi.credential.ts
│   │   │   ├── MongoDBUrlApi.credential.ts
│   │   │   ├── MySQLApi.credential.ts
│   │   │   ├── Neo4jApi.credential.ts
│   │   │   ├── NotionApi.credential.ts
│   │   │   ├── NvdiaNIMApi.credential.ts
│   │   │   ├── OpenAIApi.credential.ts
│   │   │   ├── OpenRouterApi.credential.ts
│   │   │   ├── OpenSearchUrl.credential.ts
│   │   │   ├── OpikApi.credential.ts
│   │   │   ├── OxylabsApi.credential.ts
│   │   │   ├── PerplexityApi.credential.ts
│   │   │   ├── PhoenixApi.credential.ts
│   │   │   ├── PineconeApi.credential.ts
│   │   │   ├── PostgresApi.credential.ts
│   │   │   ├── PostgresUrl.credential.ts
│   │   │   ├── QdrantApi.credential.ts
│   │   │   ├── RedisCacheApi.credential.ts
│   │   │   ├── RedisCacheUrlApi.credential.ts
│   │   │   ├── ReplicateApi.credential.ts
│   │   │   ├── SambanovaApi.credential.ts
│   │   │   ├── SearchApi.credential.ts
│   │   │   ├── SerpApi.credential.ts
│   │   │   ├── SerperApi.credential.ts
│   │   │   ├── SingleStoreApi.credential.ts
│   │   │   ├── SlackApi.credential.ts
│   │   │   ├── SpiderApi.credential.ts
│   │   │   ├── StripeApi.credential.ts
│   │   │   ├── SupabaseApi.credential.ts
│   │   │   ├── TavilyApi.credential.ts
│   │   │   ├── TeradataBearerToken.credential.ts
│   │   │   ├── TeradataTD2.credential.ts
│   │   │   ├── TeradataVectorStoreApi.credential.ts
│   │   │   ├── TogetherAIApi.credential.ts
│   │   │   ├── UnstructuredApi.credential.ts
│   │   │   ├── UpstashRedisApi.credential.ts
│   │   │   ├── UpstashRedisMemoryApi.credential.ts
│   │   │   ├── UpstashVectorApi.credential.ts
│   │   │   ├── VectaraApi.credential.ts
│   │   │   ├── VoyageAIApi.credential.ts
│   │   │   ├── WeaviateApi.credential.ts
│   │   │   ├── WolframAlphaApp.credential.ts
│   │   │   ├── XaiApi.credential.ts
│   │   │   └── ZepMemoryApi.credential.ts
│   │   ├── evaluation/
│   │   │   ├── EvaluationRunner.ts
│   │   │   ├── EvaluationRunTracer.ts
│   │   │   └── EvaluationRunTracerLlama.ts
│   │   ├── nodes/
│   │   │   ├── agentflow/
│   │   │   ├── agents/
│   │   │   ├── analytic/
│   │   │   ├── cache/
│   │   │   ├── chains/
│   │   │   ├── chatmodels/
│   │   │   ├── documentloaders/
│   │   │   ├── embeddings/
│   │   │   ├── engine/
│   │   │   ├── graphs/
│   │   │   ├── llms/
│   │   │   ├── memory/
│   │   │   ├── moderation/
│   │   │   ├── multiagents/
│   │   │   ├── outputparsers/
│   │   │   ├── prompts/
│   │   │   ├── recordmanager/
│   │   │   ├── responsesynthesizer/
│   │   │   ├── retrievers/
│   │   │   ├── sequentialagents/
│   │   │   ├── speechtotext/
│   │   │   ├── textsplitters/
│   │   │   ├── tools/
│   │   │   ├── utilities/
│   │   │   └── vectorstores/
│   │   ├── src/
│   │   │   ├── agentflow/
│   │   │   ├── agentflowv2Generator.ts
│   │   │   ├── agents.ts
│   │   │   ├── awsToolsUtils.ts
│   │   │   ├── error.ts
│   │   │   ├── followUpPrompts.ts
│   │   │   ├── google-utils.ts
│   │   │   ├── handler.test.ts
│   │   │   ├── handler.ts
│   │   │   ├── httpSecurity.ts
│   │   │   ├── index.ts
│   │   │   ├── indexing.ts
│   │   │   ├── Interface.Evaluation.ts
│   │   │   ├── Interface.ts
│   │   │   ├── MetricsLogger.ts
│   │   │   ├── modelLoader.ts
│   │   │   ├── multiModalUtils.ts
│   │   │   ├── secureZodParser.ts
│   │   │   ├── speechToText.ts
│   │   │   ├── storageUtils.ts
│   │   │   ├── textToSpeech.ts
│   │   │   ├── utils.ts
│   │   │   └── validator.ts
│   │   ├── gulpfile.ts
│   │   ├── jest.config.js
│   │   ├── models.json
│   │   ├── package.json
│   │   ├── README-ZH.md
│   │   ├── README.md
│   │   └── tsconfig.json
│   ├── fb-front/
│   │   ├── client/
│   │   │   ├── public/
│   │   │   ├── src/
│   │   │   └── index.html
│   │   ├── dist_test/
│   │   ├── shared/
│   │   │   ├── schema.ts
│   │   │   └── whatsapp-note-reminder-template.txt
│   │   ├── .gitignore
│   │   ├── .replit
│   │   ├── components.json
│   │   ├── design_guidelines.md
│   │   ├── Dockerfile
│   │   ├── package.json
│   │   ├── pnpm-workspace.yaml
│   │   ├── postcss.config.cjs
│   │   ├── print-dom.js
│   │   ├── redux.md
│   │   ├── replit.md
│   │   ├── tailwind.config.ts
│   │   ├── tsconfig.json
│   │   ├── user.patch
│   │   └── vite.config.ts
│   ├── server/
│   │   ├── bin/
│   │   │   ├── .gitattributes
│   │   │   ├── dev
│   │   │   ├── dev.cmd
│   │   │   ├── run
│   │   │   └── run.cmd
│   │   ├── cypress/
│   │   │   ├── e2e/
│   │   │   ├── fixtures/
│   │   │   └── support/
│   │   ├── marketplaces/
│   │   │   ├── agentflows/
│   │   │   ├── agentflowsv2/
│   │   │   ├── chatflows/
│   │   │   └── tools/
│   │   ├── src/
│   │   │   ├── commands/
│   │   │   ├── controllers/
│   │   │   ├── database/
│   │   │   ├── enterprise/
│   │   │   ├── errors/
│   │   │   ├── metrics/
│   │   │   ├── middlewares/
│   │   │   ├── queue/
│   │   │   ├── routes/
│   │   │   ├── services/
│   │   │   ├── utils/
│   │   │   ├── workers/
│   │   │   ├── AbortControllerPool.ts
│   │   │   ├── AppConfig.ts
│   │   │   ├── CachePool.ts
│   │   │   ├── DataSource.ts
│   │   │   ├── IdentityManager.ts
│   │   │   ├── index.ts
│   │   │   ├── Interface.DocumentStore.ts
│   │   │   ├── Interface.Evaluation.ts
│   │   │   ├── Interface.Metrics.ts
│   │   │   ├── Interface.ts
│   │   │   ├── NodesPool.ts
│   │   │   ├── StripeManager.ts
│   │   │   └── UsageCacheManager.ts
│   │   ├── test/
│   │   │   ├── __mocks__/
│   │   │   ├── enterprise/
│   │   │   ├── services/
│   │   │   └── jest.setup.ts
│   │   ├── .env.example
│   │   ├── babel.config.js
│   │   ├── controller.patch
│   │   ├── cypress.config.ts
│   │   ├── fix_gupshup.js
│   │   ├── gulpfile.ts
│   │   ├── jest.config.js
│   │   ├── jest.unit.config.js
│   │   ├── nodemon.json
│   │   ├── package.json
│   │   ├── patch.js
│   │   ├── patch.txt
│   │   ├── README.md
│   │   ├── route.patch
│   │   ├── search.py
│   │   ├── test-output.log
│   │   ├── test_gupshup_upload.js
│   │   ├── testsed.patch
│   │   └── tsconfig.json
│   ├── ui/
│   │   ├── public/
│   │   │   ├── favicon-16x16.png
│   │   │   ├── favicon-32x32.png
│   │   │   ├── favicon.ico
│   │   │   ├── favicon.svg
│   │   │   ├── index.html
│   │   │   ├── logo192.png
│   │   │   ├── logo512.png
│   │   │   └── manifest.json
│   │   ├── src/
│   │   │   ├── api/
│   │   │   ├── assets/
│   │   │   ├── components/
│   │   │   ├── constants/
│   │   │   ├── hooks/
│   │   │   ├── layout/
│   │   │   ├── menu-items/
│   │   │   ├── routes/
│   │   │   ├── store/
│   │   │   ├── themes/
│   │   │   ├── ui-component/
│   │   │   ├── utils/
│   │   │   ├── views/
│   │   │   ├── App.jsx
│   │   │   ├── config.js
│   │   │   ├── ErrorBoundary.jsx
│   │   │   ├── index.jsx
│   │   │   ├── serviceWorker.js
│   │   │   └── test-fb-front-imports.jsx
│   │   ├── .env.example
│   │   ├── .npmignore
│   │   ├── craco.config.js
│   │   ├── index.html
│   │   ├── jsconfig.json
│   │   ├── package.json
│   │   ├── postcss.config.js
│   │   ├── tailwind.config.js
│   │   └── vite.config.js
│   ├── vladislav/
│   │   ├── cloud-backup/
│   │   │   ├── .flowise-backup.conf
│   │   │   ├── backup-to-mailru.sh
│   │   │   ├── backup-util.sh
│   │   │   ├── flowise-backup.log
│   │   │   └── install-backup-cron.sh
│   │   ├── local-json/
│   │   │   ├── tools/
│   │   │   ├── _export-summary.json
│   │   │   ├── agentflow-nodes.json
│   │   │   ├── credential.json
│   │   │   ├── dev-config.json
│   │   │   ├── facebook_ad.json
│   │   │   ├── facebook_ad_account.json
│   │   │   ├── facebook_ad_account_activity.json
│   │   │   ├── facebook_ads_insight.json
│   │   │   ├── facebook_ads_project_.json
│   │   │   ├── facebook_adset.json
│   │   │   ├── facebook_asset_insight.json
│   │   │   ├── facebook_attribution_query.json
│   │   │   ├── facebook_audience.json
│   │   │   ├── facebook_campaign.json
│   │   │   ├── facebook_capi_event.json
│   │   │   ├── facebook_capi_event_log.json
│   │   │   ├── facebook_creative.json
│   │   │   ├── facebook_creative_insight.json
│   │   │   ├── facebook_daily_snapshot.json
│   │   │   ├── facebook_dataset.json
│   │   │   ├── facebook_entity_attributes.json
│   │   │   ├── facebook_entity_diff.json
│   │   │   ├── facebook_entity_issue.json
│   │   │   ├── facebook_event_quality.json
│   │   │   ├── facebook_event_template.json
│   │   │   ├── facebook_first_party_domain.json
│   │   │   ├── facebook_insights_fetch_log.json
│   │   │   ├── facebook_learning_stage.json
│   │   │   ├── facebook_page.json
│   │   │   ├── facebook_performance_delta.json
│   │   │   ├── facebook_pixel.json
│   │   │   ├── facebook_sync_job.json
│   │   │   ├── facebook_sync_step.json
│   │   │   ├── facebook_token_audit.json
│   │   │   ├── facebook_user_settings.json
│   │   │   ├── facebook_webhook_log.json
│   │   │   ├── fb_front_notification.json
│   │   │   ├── localStorage-init.json
│   │   │   ├── meta_insights_raw.json
│   │   │   ├── organization.json
│   │   │   ├── organization_user.json
│   │   │   ├── user.json
│   │   │   ├── workspace.json
│   │   │   ├── workspace_facebook_config.json
│   │   │   └── workspace_user.json
│   │   ├── pnpm/
│   │   │   └── collect-logs.sh
│   │   └── test-event-capi/
│   │       ├── decrypt-credential.mjs
│   │       └── test-all-events.js
│   └── whatsapp/
│       ├── builder/
│       │   ├── client/
│       │   ├── shared/
│       │   ├── .gitignore
│       │   ├── components.json
│       │   ├── design_guidelines.md
│       │   ├── Dockerfile
│       │   ├── package-lock.json
│       │   ├── package.json
│       │   ├── postcss.config.js
│       │   ├── tailwind.config.ts
│       │   ├── TECHNICAL_SPEC.md
│       │   ├── tsconfig.json
│       │   └── vite.config.ts
│       ├── chat/
│       │   ├── client/
│       │   ├── shared/
│       │   ├── .gitignore
│       │   ├── components.json
│       │   ├── Dockerfile
│       │   ├── package.json
│       │   ├── postcss.config.js
│       │   ├── tailwind.config.ts
│       │   ├── tsconfig.json
│       │   └── vite.config.ts
│       └── portal/
│           ├── client/
│           ├── shared/
│           ├── .gitignore
│           ├── components.json
│           ├── Dockerfile
│           ├── package.json
│           ├── postcss.config.js
│           ├── tailwind.config.ts
│           ├── tsconfig.json
│           └── vite.config.ts
├── plans/
│   ├── campaigns-zero-workspace-theft--13-26--07-03-2026--consilium.md
│   ├── capi-event-matrix-validation--20-45--12-03-2026--consilium.md
│   ├── capi-live-monitor-csp--01-03--10-04-2026--consilium.md
│   ├── cascade-e2e-rehabilitation--12-30--26-03-2026--consilium.md
│   ├── consilium-20260222-0635-complete.md
│   ├── consilium-20260222-1430.md
│   ├── consilium-20260224-0010.md
│   ├── consilium-20260301-1530.md
│   ├── consilium-20260301-2130.md
│   ├── consilium-20260304-1747.md
│   ├── consilium-20260305-0800.md
│   ├── consilium-20260305-1200.md
│   ├── consilium-20260305-analytics-sse-breakdown.md
│   ├── consilium-20260305-SUMMARY.md
│   ├── consilium-20260306-reminder-nested-popup-phase-1-complete.md
│   ├── consilium-collector-url-fix.md
│   ├── consilium-whatsapp-redux-reuse-20260304-180000.md
│   ├── crm-wizard-gupshup-numbers-phase-1-complete.md
│   ├── crm-wizard-gupshup-numbers-plan.md
│   ├── datahouse-completion-plan--2026-03-24.md
│   ├── delete-whatsapp-app-e2e--02-41--08-03-2026--consilium.md
│   ├── facebook-bootstrap-report-sequencing-plan--2026-04-14.md
│   ├── facebook-observability-lab.md
│   ├── gtm-capi-e2e-fix--15-30--08-03-2026--consilium-final.md
│   ├── gtm-capi-e2e-fix--15-30--08-03-2026--consilium.md
│   ├── gtm-capi-eventInstanceId-plan.md
│   ├── gtm-capi-full-audit--12-00--26-03-2026--consilium.md
│   ├── gtm-e2e-cascade-map-2026-03-27.md
│   ├── gtm-step5-ai-modal-mockup.md
│   ├── gupshup-media-429-saas-phase-1-complete.md
│   ├── gupshup-media-429-saas-phase-2-complete.md
│   ├── gupshup-media-429-saas-phase-3-complete.md
│   ├── gupshup-media-429-saas-plan.md
│   ├── live-monitor-seed-forensics-2026-03-03.md
│   ├── media-upload-ux-fix-plan.md
│   ├── notification-bell-handoff--21-09--07-03-2026.md
│   ├── pixel-pii-unified-consilium--09-03-2026.md
│   ├── rkx-trigger-crm-contract-refactor-plan--2026-04-14.md
│   ├── selection-badge-filter--14-32--07-03-2026--consilium.md
│   ├── selection-filter--12-00--07-03-2026--consilium.md
│   ├── shared-bm-architecture--20-30--07-03-2026--consilium.md
│   ├── step7-full-fix.patch
│   ├── unread-count-timeout--13-15--07-03-2026--consilium.md
│   ├── vr-capi-gtm.md
│   ├── wa-gupshup-incident-2026-03-04-initial-findings.md
│   ├── wa-gupshup-incident-2026-03-04-logscan.txt
│   ├── wa-template-status-audit-20260308.md
│   └── whatsapp-chat-diff-review--20-30--07-03-2026--consilium.md
├── scripts/
│   ├── apply-custom-trigger-and-cache-fix.mjs
│   ├── clean_and_build.sh
│   ├── fix-express-rate-limit-tsconfig.mjs
│   ├── generate-project-tree.sh
│   ├── patch-custom-trigger-cache.mjs
│   ├── test-gupshup-webhook.sh
│   ├── update-project-tree.sh
│   └── wp-agency-readonly-diagnostics.sh
├── package.json
├── pnpm-workspace.yaml
├── README.md
├── tsconfig.json
└── turbo.json
```

## Update Policy
Regenerate this snapshot only when structure changes (new modules/folders/routes/services/migrations), not after every code edit.
