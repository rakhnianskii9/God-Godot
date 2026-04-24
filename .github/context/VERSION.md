# Godot Engine — Version Reference

| Field | Value |
|-------|-------|
| **Engine Version** | Godot 4.6 |
| **Release Date** | January 2026 |
| **Project Pinned** | 2026-02-12 |
| **Last Docs Verified** | 2026-02-12 |
| **LLM Knowledge Cutoff** | May 2025 |

## Knowledge Gap Warning

The model's training data likely covers Godot up to about 4.3. Versions 4.4,
4.5, and 4.6 introduced material changes that must be cross-checked against
the curated reference files in `.github/context/` before suggesting version-
sensitive Godot APIs or migration guidance.

## Post-Cutoff Version Timeline

| Version | Release | Risk Level | Key Theme |
|---------|---------|------------|-----------|
| 4.4 | Mid 2025 | Medium | FileAccess return values, shader texture type changes |
| 4.5 | Late 2025 | High | Accessibility, variadic args, `@abstract`, shader baker, SMAA |
| 4.6 | Jan 2026 | High | Jolt default, glow rework, D3D12 default on Windows, IK restored |

## Curated Reference Files

- `.github/context/breaking-changes.md`
- `.github/context/deprecated-apis.md`
- `.github/context/current-best-practices.md`
- `.github/context/modules/*.md`

## Verification Sources

- Official docs: https://docs.godotengine.org/en/stable/
- 4.5 to 4.6 migration: https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.6.html
- 4.4 to 4.5 migration: https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.5.html
- Changelog: https://github.com/godotengine/godot/blob/master/CHANGELOG.md
- Release notes: https://godotengine.org/releases/4.6/