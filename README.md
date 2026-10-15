# testkit

Reusable GoML test helpers, extracted from the former verification runner. The module is `ecosystem::testkit`; its `reference` package depends only on the standard library.

```toml
[dev-dependencies]
"ecosystem::testkit" = true
```

```goml
use ecosystem::testkit::reference;

let expected = reference::load("tests/data/reference.json");
let actual = reference::run_json("./_artifact/bin/my_program", expected);
```

The package provides JSON fixture decoding and comparisons, subprocess protocol checks with explicit executable paths, and an independent terminal `Screen` model. See [the reference API notes](reference/README.md) for timeouts, compressed fixture formats, and the screen model's intentionally limited Unicode coverage. It does not discover ecosystem directory layouts or read runner environment variables.

Use the [current GoML toolchain](https://github.com/gomlang/workflows/blob/main/ci/toolchain.json):

```sh
goml test --timeout 300s
goml run --example basic
```

Fixture decompression requires `gzip`. Process tests use Linux/POSIX `/bin/cat`, `/bin/false`, and `/bin/sh`. Shared CI and cross-repository verification live in [gomlang/workflows](https://github.com/gomlang/workflows).
