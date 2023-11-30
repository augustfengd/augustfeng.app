[private]
default:
    @just --list

server:
    open http://localhost:1313
    hugo server

lint:
    #!/usr/bin/env bash
    set -euxo pipefail
    emacs --script scripts/linter/linter.el -f program | cue vet -t blog_dir=$(pwd) scripts/linter/linter.cue json: -
