package scripts

import (
	"github.com/augustfengd/augustfeng.app:augustfeng"
	"github.com/augustfengd/augustfeng.app/.github:terraform"
	"encoding/yaml"
	"tool/file"
)

command: build: {
	"terraform.yml": file.Create & {
		filename: "workflows/terraform.yml"
		contents: yaml.Marshal(terraform & {#c: augustfeng.actions})
	}
}
