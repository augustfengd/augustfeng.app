[private]
default:
    @just --list

serve:
    hugo --buildDrafts server

lint:
    #!/usr/bin/env bash
    set -euxo pipefail
    emacs --script scripts/linter/linter.el -f program | cue vet -t blog_dir=$(pwd) scripts/linter/linter.cue json: -
