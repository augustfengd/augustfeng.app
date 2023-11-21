default:
    @just --color=always --list | grep --invert default

server:
    open http://localhost:1313
    hugo server
