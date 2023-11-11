default:
    @just --list --unsorted --color always | grep --invert default

build:
    go build

run command: build
    case "{{command}}" in \
        "keywords") \
            ./lint keywords --file test/data/example.org \
        ;; \
        "titles") \
            ./lint titles --directory ../content/ \
        ;; \
    esac


clean:
    rm lint
