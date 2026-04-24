---
name: team-narrative
description: "Orchestrate the narrative team: coordinates narrative-director, art-director, and level-designer to create cohesive story content, world lore, dialogue, and narrative-driven level design."
argument-hint: "[narrative content description]"
user-invocable: true
---
If no argument is provided, output usage guidance and exit without spawning any agents:
> Usage: `/team-narrative [narrative content description]` — describe the story content, scene, or narrative area to work on (e.g., `boss encounter cutscene`, `faction intro dialogue`, `tutorial narrative`). Do not use `vscode_askQuestions` here; output the guidance directly.

When this skill is invoked with an argument, orchestrate the narrative team through a structured pipeline.

**Decision Points:** At each phase transition, use `vscode_askQuestions` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

## Team Composition
- **narrative-director** — Story arcs, character design, dialogue strategy, narrative vision, dialogue writing, lore entries, in-game text
- **art-director** — Character visual design, environmental visual storytelling, cutscene/cinematic tone
- **level-designer** — Level layouts that serve the narrative, pacing, environmental storytelling beats

## How to Delegate

Use the Task tool to spawn each team member as a subagent:
- `subagent_type: narrative-director` — Story arcs, character design, narrative vision, world rules, faction design, history, geography, dialogue writing, lore entries, in-game text
- `subagent_type: art-director` — Character visual profiles, environmental visual storytelling, cinematic tone
- `subagent_type: level-designer` — Level layouts that serve the narrative, pacing
- `subagent_type: ux-designer` — i18n headroom, string-key discipline, and player-facing text constraints in UI

Always provide full context in each agent's prompt (narrative brief, lore dependencies, character profiles). Launch independent agents in parallel where the pipeline allows it (e.g., Phase 2 agents can run simultaneously).

## Pipeline

### Phase 1: Narrative Direction
Delegate to **narrative-director**:
- Define the narrative purpose of this content: what story beat does it serve?
- Identify characters involved, their motivations, and how this fits the overall arc
- Set the emotional tone and pacing targets
- Specify any lore dependencies or new lore this introduces
- Create or update lore entries for factions, locations, and history relevant to this content
- Output: narrative brief with story requirements

### Phase 2: World Foundation (parallel)
Delegate in parallel — issue both Task calls simultaneously before waiting for any result:
- **narrative-director**: Draft character dialogue and lore-facing text using voice profiles. Ensure all lines are under 120 characters, use named placeholders for variables, and are localization-ready.
- **art-director**: Define character visual design direction for key characters appearing in this content (silhouette, visual archetype, distinguishing features). Specify environmental visual storytelling elements for each key space (prop composition, lighting notes, spatial arrangement). Define tone palette and cinematic direction for any cutscenes or scripted sequences.

### Phase 3: Level Narrative Integration
Delegate to **level-designer**:
- Review the narrative brief and lore foundation
- Design environmental storytelling elements in the level
- Place narrative triggers, dialogue zones, and discovery points
- Ensure pacing serves both gameplay and story

### Phase 4: Review and Consistency
Delegate to **narrative-director**:
- Review all dialogue against character voice profiles
- Verify lore consistency across new and existing entries
- Confirm narrative pacing aligns with level design
- Check that all mysteries have documented "true answers"

### Phase 5: Polish (parallel)
Delegate in parallel:
- **narrative-director**: Final self-review — verify no line exceeds dialogue box constraints, all text uses string keys (not raw strings), placeholder variable names are consistent
- **ux-designer**: Validate i18n readiness — check string key naming conventions, flag any text patterns that will not survive translation, verify character limit headroom for languages that expand (German/Finnish typically +30%), and note any UI-facing locale risks for follow-up through `/localize`
- **narrative-director**: Finalize canon levels for all new lore entries

## Error Recovery Protocol

If any spawned agent (via Task) returns BLOCKED, errors, or cannot complete:

1. **Surface immediately**: Report "[AgentName]: BLOCKED — [reason]" to the user before continuing to dependent phases
2. **Assess dependencies**: Check whether the blocked agent's output is required by subsequent phases. If yes, do not proceed past that dependency point without user input.
3. **Offer options** via vscode_askQuestions with choices:
   - Skip this agent and note the gap in the final report
   - Retry with narrower scope
   - Stop here and resolve the blocker first
4. **Always produce a partial report** — output whatever was completed. Never discard work because one agent blocked.

Common blockers:
- Input file missing (story not found, GDD absent) → redirect to the skill that creates it
- ADR status is Proposed → do not implement; run `/architecture-decision` first
- Scope too large → split into two stories via `/create-stories`
- Conflicting instructions between ADR and story → surface the conflict, do not guess

## File Write Protocol

All file writes (narrative docs, dialogue files, lore entries) are delegated to
sub-agents spawned via Task. Each sub-agent enforces the "May I write to [path]?"
protocol. This orchestrator does not write files directly.

## Output

A summary report covering: narrative brief status, lore entries created/updated, dialogue lines written, level narrative integration points, consistency review results, and any unresolved contradictions.

Verdict: **COMPLETE** — narrative content delivered.

If the pipeline stops because a dependency is unresolved (e.g., lore contradiction or missing prerequisite not resolved by the user):

Verdict: **BLOCKED** — [reason]

## Next Steps

- Run `/design-review` on the narrative documents for consistency validation.
- Run `/localize extract` to extract new strings for translation after dialogue is finalized.
- Run `/dev-story` to implement dialogue triggers and narrative events in-engine.
