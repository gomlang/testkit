# Native reference test support

Black-box tests use this package to load independent reference inputs and expected values, compare JSON trees, and call consumer protocols with a 120-second process timeout. Process operations return `Result`; test assertions identify failed reference operations. Test fixtures record their model, seed, case count, source revision, and SHA-256 in the adjacent `tests/data/README.md`.

Large fixtures share repeated subtrees using the documented `indexed-json-v2` format. Decoding preserves integer number tokens and does not round through floating point. Object comparison ignores field order. Expected values come from independent specifications, GNU/Git/reference implementations, or the former independent models, never from recorded GoML output.

`Screen` independently replays the terminal sequences emitted in the TUI and ANSI test corpus. It handles fragmented UTF-8/CSI/OSC, cursor positions, SGR colors/attributes, wide-cell overlap, combining marks, and the emoji ZWJ clusters used in these tests. Its controlled-corpus width rules cover CJK U+2E80–U+9FFF, emoji U+1F300–U+1FAFF, combining U+0300–U+036F and variation selectors. It is a test model, not a general Unicode terminal emulator; it deliberately has no dependency on the ANSI, TUI, terminal, or Unicode libraries being tested.

Paths are explicit: `load(path)` and `load_text(path)` read the supplied fixture base path, and `output(executable, argument, input)`, `run(executable, argument, input)`, and `run_json(executable, value)` launch the supplied executable. They do not inspect environment variables or guess an example directory. `load` accepts ordinary JSON or indexed-json-v2 inside `.gz` or contiguous `.gz.0`, `.gz.1`, … chunks. Decoding invokes `gzip -dc` with a 30-second timeout; execution helpers use a 120-second timeout. `run` rejects nonzero exit status and unexpected stderr.

Project-specific choices such as locating a compiled example, honoring runner environment variables, choosing fixture roots, or running Linux PTY scenarios belong to the consuming project or the [workflows repository](https://github.com/gomlang/workflows).
