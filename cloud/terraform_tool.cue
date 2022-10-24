package terraform

import (
	"tool/http"
	"encoding/json"
)

command: configure: {
	workspace: http.Do & {
		organization: configuration.terraform.cloud.organization
		name:         configuration.terraform.cloud.workspaces.name
		url:          "https://\(configuration.terraform.cloud.hostname)/api/v2/organizations/\(organization)/workspaces/\(name)"
		id:           json.Unmarshal(response.body).data.id
		method:       "PATCH"
		request: {
			body: json.Marshal({data: {type: "workspaces", attributes: configuration.terraform.cloud.#settings}})
			header: {
				"Content-Type":  "application/vnd.api+json"
				"Authorization": "Bearer \(configuration.terraform.cloud.token)"
			}
		}
		response: {
			statusCode: 200
		}
	}
	workspaceVars: http.Get & {
		$dep: command.configure.workspace.$done
		url:  "https://\(configuration.terraform.cloud.hostname)/api/v2/workspaces/\(workspace.id)/vars"
		data: json.Unmarshal(response.body).data
		request: {
			header: "Authorization": "Bearer \(configuration.terraform.cloud.token)"
		}
		response: {
			statusCode: 200
		}
	}
	for _, var in configuration.terraform.cloud.#vars {
		(var.key): http.Do & {
			$dep: command.configure.workspaceVars.$done
			varsFound: [ for _, v in workspaceVars.data if v.attributes.key == var.key && v.attributes.category == var.category {v}]
			if len(varsFound) > 0 {
				variable_id: varsFound[0].id
				method:      "PATCH"
				url:         "https://\(configuration.terraform.cloud.hostname)/api/v2/workspaces/\(workspace.id)/vars/\(variable_id)"
			}
			if len(varsFound) == 0 {
				method: "POST"
				url:    "https://\(configuration.terraform.cloud.hostname)/api/v2/workspaces/\(workspace.id)/vars"
			}
			request: {
				body: json.Marshal({data: {type: "vars", attributes: var & {description: "configured by terraform_tool.cue"}}})
				header:
				{
					"Content-Type":  "application/vnd.api+json"
					"Authorization": "Bearer \(configuration.terraform.cloud.token)"
				}
			}
			response: {
				statusCode: 200 | 201
			}
		}
	}
}
