package scripts

import (
	"github.com/augustfengd/augustfeng.app:augustfeng"
	"github.com/augustfengd/augustfeng.app/terraform:terraform"
	"tool/http"
	"tool/file"
	"encoding/json"
)

command: build: {
	"mkdir": file.MkdirAll & {
		path: "../build/terraform"
	}
	"write": file.Create & {
		$dep:     command.build["mkdir"].$done
		filename: "../build/terraform/main.tf.json"
		contents: {
			let data = json.Marshal(terraform & {#c: augustfeng.terraform})
			json.Indent(data, "", " ")
		}
	}
}

command: configure: {
	#workspace: augustfeng.terraform.workspace
	workspace:  http.Do & {
		organization: #workspace.organization
		name:         #workspace.name
		url:          "https://\(#workspace.hostname)/api/v2/organizations/\(organization)/workspaces/\(name)"
		id:           json.Unmarshal(response.body).data.id
		method:       "PATCH"
		request: {
			body: json.Marshal({data: {type: "workspaces", attributes: augustfeng.terraform.workspace.settings}})
			header: {
				"Content-Type":  "application/vnd.api+json"
				"Authorization": "Bearer \(#workspace.token)"
			}
		}
		response: {
			statusCode: 200
		}
	}
	workspaceVars: http.Get & {
		$dep: command.configure.workspace.$done
		url:  "https://\(#workspace.hostname)/api/v2/workspaces/\(workspace.id)/vars"
		data: json.Unmarshal(response.body).data
		request: {
			header: "Authorization": "Bearer \(#workspace.token)"
		}
		response: {
			statusCode: 200
		}
	}
	for _, var in augustfeng.terraform.workspace.vars {
		(var.key): http.Do & {
			$dep: command.configure.workspaceVars.$done
			varsFound: [ for _, v in workspaceVars.data if v.attributes.key == var.key && v.attributes.category == var.category {v}]
			if len(varsFound) > 0 {
				variable_id: varsFound[0].id
				method:      "PATCH"
				url:         "https://\(#workspace.hostname)/api/v2/workspaces/\(workspace.id)/vars/\(variable_id)"
			}
			if len(varsFound) == 0 {
				method: "POST"
				url:    "https://\(#workspace.hostname)/api/v2/workspaces/\(workspace.id)/vars"
			}
			request: {
				body: json.Marshal({data: {type: "vars", attributes: var & {description: "configured by terraform_tool.cue"}}})
				header:
				{
					"Content-Type":  "application/vnd.api+json"
					"Authorization": "Bearer \(#workspace.token)"
				}
			}
			response: {
				statusCode: 200 | 201
			}
		}
	}
}
