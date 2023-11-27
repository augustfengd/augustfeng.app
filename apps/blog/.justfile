alias l := lint

[private]
default:
    @just --list

server:
    open http://localhost:1313
    hugo server

lint:
    emacs --script scripts/lint.el
