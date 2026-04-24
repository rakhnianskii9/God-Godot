# Godot Agent Test Specs

These specs preserve the useful Godot-specific QA intent from a retired external
framework, but normalize it to the active workspace contract in this repository.

Use them as review prompts when editing `.github/agents/godot-*.agent.md`.

## godot-specialist

### Scope

- Owns Godot-specific architecture decisions: scenes, nodes, signals, resources,
  and language-boundary guidance.
- Does not own language-specific implementation when the request clearly belongs
  to GDScript, C#, or GDExtension specialists.

### Structural Checks

- [ ] `description` is Godot-specific and not generic engine text
- [ ] Body references `.github/instructions/code-rules.instructions.md`
- [ ] Version-aware guidance points at `.github/context/VERSION.md`
- [ ] Body does not rely on retired tool names or deleted orchestration layers

### Test Cases

1. Signals vs direct calls:
Input: `When should I use signals vs direct method calls in Godot?`
Expected: Returns a pattern decision guide with trade-offs, examples, and escalation to a language specialist only if code authoring is requested.

2. Wrong-engine redirect:
Input: `Write a MonoBehaviour that runs on Start() and subscribes to a UnityEvent.`
Expected: Does not produce Unity code, maps the concept to Godot `_ready()` and signals, and states that the project is Godot-first.

3. Post-cutoff feature risk:
Input: `Use the new Godot 4.5 @abstract annotation to define an abstract base class.`
Expected: Flags this as post-cutoff, checks `.github/context/VERSION.md`, and recommends verification against official Godot docs before asserting syntax details.

4. Language selection for a hot path:
Input: `The physics query loop runs every frame for 500 objects. Should we use GDScript or C# for this?`
Expected: Provides trade-offs, includes GDExtension as an escalation path, and does not make a unilateral language choice when the decision is architectural.

5. Godot 4.6 context use:
Input: `Set up a RigidBody3D for the player character.`
Expected: Applies Jolt-default knowledge from `.github/context/VERSION.md` and `.github/context/modules/physics.md`, and flags GodotPhysics-only settings when relevant.

## godot-gdscript-specialist

### Scope

- Owns GDScript typing, coroutine patterns, signal architecture, idioms, and
  GDScript-specific performance concerns.
- Does not own shader authoring or native extension bindings.

### Structural Checks

- [ ] `description` clearly targets GDScript work
- [ ] Body references `.github/context/current-best-practices.md`
- [ ] No deprecated Godot 3 patterns are encouraged (`yield`, string-based `connect`)
- [ ] Redirect boundaries to shader and GDExtension specialists are explicit

### Test Cases

1. Type coverage review:
Input: `Review this GDScript file for type annotation coverage.`
Expected: Produces line-specific findings instead of silently rewriting the whole file.

2. Out-of-domain shader request:
Input: `Write a vertex shader to distort the mesh in world space.`
Expected: Redirects to `godot-shader-specialist` and limits itself to GDScript-side shader parameter wiring if needed.

3. Async loading:
Input: `Load a scene asynchronously and wait for it to finish before spawning it.`
Expected: Uses Godot 4 `await` and typed values, not Godot 3 `yield()`.

4. Typed-array performance:
Input: `The entity update loop is slow; it iterates an untyped Array of 1,000 nodes every frame.`
Expected: Recommends typed arrays as the first grounded fix and only escalates to C# after profiling evidence.

5. Godot 4.6 post-cutoff feature:
Input: `Create an abstract base class for all enemy types using @abstract.`
Expected: Flags `@abstract` as 4.5+, references `.github/context/VERSION.md`, and marks any syntax-dependent answer as requiring official-doc verification.

## godot-csharp-specialist

### Scope

- Owns Godot C# patterns, exports, signal delegates, async usage, and thread
  safety in the Godot/.NET boundary.
- Does not own GDScript authoring or GDExtension bindings.

### Structural Checks

- [ ] `description` is specific to C# in Godot, not generic .NET advice
- [ ] Body references `.github/context/current-best-practices.md` or other current context refs when version-sensitive
- [ ] Thread-safety constraints for Godot nodes are explicit
- [ ] Redirects to GDScript and GDExtension specialists are explicit

### Test Cases

1. Export property with validation:
Input: `Create an export property for enemy health with validation that clamps it between 1 and 1000.`
Expected: Uses a Godot C# export pattern with validation, not a loose public field.

2. GDScript redirect:
Input: `Rewrite this enemy health system in GDScript.`
Expected: Redirects to `godot-gdscript-specialist` and does not mix languages casually.

3. Async signal awaiting:
Input: `Wait for an animation to finish before transitioning game state using C# async.`
Expected: Uses `ToSignal()` and `async Task`, not `Task.Delay()` polling.

4. Background-thread misuse:
Input: `This C# code accesses a Godot Node from a background Task thread to update its position.`
Expected: Flags it as unsafe, recommends marshalling back to the main thread, and does not approve direct threaded node access.

5. Typed signal pattern:
Input: `Connect a signal using the typed signal delegate pattern.`
Expected: Uses the Godot 4 typed delegate approach and avoids deprecated string-based `Connect()` guidance.

## godot-shader-specialist

### Scope

- Owns Godot shading language, material setup, particle shaders, and
  post-processing guidance.
- Does not own gameplay logic or art-direction approval.

### Structural Checks

- [ ] `description` explicitly references Godot shaders/materials
- [ ] Body references `.github/context/modules/rendering.md`
- [ ] No HLSL or raw-GLSL guidance is presented as native Godot syntax
- [ ] Post-cutoff rendering changes are treated as version-sensitive

### Test Cases

1. Dissolve shader:
Input: `Write a dissolve effect shader for enemy death in Godot.`
Expected: Produces valid Godot shader code with the right shader type, uniforms, and discard behavior.

2. HLSL redirect:
Input: `Write an HLSL compute shader for this dissolve effect.`
Expected: Explains that Godot does not use HLSL directly and translates the request into an appropriate Godot rendering path.

3. Texture API change risk:
Input: `Use texture() with a sampler2D to sample the noise texture in the shader.`
Expected: Checks `.github/context/breaking-changes.md` and `.github/context/modules/rendering.md` for post-4.3 texture-type changes before asserting syntax.

4. Fragment-cost reduction:
Input: `The fragment shader for the water surface has 8 texture samples and is causing GPU bottlenecks on mid-range hardware.`
Expected: Identifies sample count as the cost driver and proposes LOD or pre-baking strategies without changing gameplay behavior.

5. Glow rework awareness:
Input: `Add a bloom/glow post-processing effect to the scene.`
Expected: Uses 4.6-aware guidance and flags any likely training-data mismatch around the glow pipeline.

## godot-gdextension-specialist

### Scope

- Owns GDExtension, godot-cpp, godot-rust, ABI risk, and native performance
  boundaries.
- Does not own GDScript authoring or shader authoring.

### Structural Checks

- [ ] `description` is specific to GDExtension/native bindings
- [ ] Body treats ABI compatibility as version-sensitive
- [ ] Body references `.github/context/VERSION.md` and `.github/context/breaking-changes.md`
- [ ] Redirects to GDScript and shader specialists remain explicit

### Test Cases

1. Binding pattern:
Input: `Expose a C++ rigid-body physics simulation library to GDScript via GDExtension.`
Expected: Produces a Godot-specific binding pattern and manifest checklist, not only generic C++ advice.

2. GDScript redirect:
Input: `Write the GDScript that calls the physics simulation.`
Expected: Redirects to `godot-gdscript-specialist` and keeps the handoff at the API-surface level.

3. ABI risk on upgrade:
Input: `We're upgrading from Godot 4.5 to 4.6. Will our existing GDExtension still work?`
Expected: Flags ABI risk, recommends recompilation, and checks the official migration path instead of assuming binary compatibility.

4. Godot object lifetime:
Input: `How should we manage the lifecycle of Godot objects created inside C++ GDExtension code?`
Expected: Uses Godot-specific ownership patterns such as `Ref<T>` and `memnew`/`memdelete`, not generic `new`/`delete` guidance.

5. 4.6 compatibility check:
Input: `Check if any GDExtension APIs changed from 4.5 to 4.6.`
Expected: Uses `.github/context/VERSION.md` as the starting point, then advises checking official migration notes or changelog entries for final confirmation.