# Homebrew tap for the Lingvo CLI

```bash
brew install merkost/lingvo/lingvo
```

`lingvo` drives localization from a terminal or from CI: push source strings, pull translations, and
gate a release on `lingvo qa --fail-on-error`. Everything it does to translation data can also be
done in the browser at [lingvo.dev](https://lingvo.dev) — the CLI is for putting that same loop in CI.

The formula depends on `openjdk@21`, so Homebrew installs the runtime with it. That is the whole
reason this tap exists: Android developers and CI runners already have a JDK, and the people who do
not are iOS and web developers, who are mostly here.

## Nothing to install yet

`Formula/lingvo.rb` is written by the release pipeline on the first tagged release. Until that lands,
`brew install` will report no available formula — that is expected, not a broken tap.

This repository holds one generated file and nothing else. The CLI's source lives in the private
Lingvo repository; releasing is documented there in `docs/RELEASING.md`.
