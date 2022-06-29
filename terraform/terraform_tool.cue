package terraform

import (
	"github.com/augustfengd/augustfeng.app/terraform:config"
	"encoding/json"
	"strings"
	"tool/http"
	"tool/file"
	"tool/os"
)

command: configure: {
	cloud: terraform.cloud
	osEnv: os.Getenv & {
		HOME:                                                          string
		(strings.Replace("TF_TOKEN_\(cloud.hostname)", ".", "_", -1)): string
	}
	tfrc: file.Read & {
		$dep:     command.configure.osEnv.$done
		override: (osEnv[ (strings.Replace("TF_TOKEN_\(cloud.hostname)", ".", "_", -1))] & string) != _|_
		if override {
			filename: "/etc/hosts" // hack: just read anything, we don't care in case of override.
			token:    osEnv[ (strings.Replace("TF_TOKEN_\(cloud.hostname)", ".", "_", -1))]
		}
		if !override {
			filename: "\(osEnv.HOME)/.terraform.d/credentials.tfrc.json"
			token:    json.Unmarshal(contents).credentials[cloud.hostname].token
			contents: string
		}
	}
	workspace: http.Do & {
		$dep:         command.configure.tfrc.$done
		organization: cloud.organization
		name:         cloud.workspaces.name
		url:          "https://\(cloud.hostname)/api/v2/organizations/\(organization)/workspaces/\(name)"
		id:           json.Unmarshal(response.body).data.id
		method:       "PATCH"
		request: {
			body: json.Marshal({data: {type: "workspaces", attributes: config.terraform.workspace.settings}})
			header: {
				"Content-Type":  "application/vnd.api+json"
				"Authorization": "Bearer \(tfrc.token)"
			}
		}
		response: {
			statusCode: 200
		}
	}
	workspaceVars: http.Get & {
		$dep: command.configure.workspace.$done
		url:  "https://\(cloud.hostname)/api/v2/workspaces/\(workspace.id)/vars"
		data: json.Unmarshal(response.body).data
		request: {
			header: "Authorization": "Bearer \(tfrc.token)"
		}
		response: {
			statusCode: 200
		}
	}
	for _, var in config.terraform.workspace.vars {
		(var.key): http.Do & {
			$dep: command.configure.workspaceVars.$done
			varsFound: [ for _, v in workspaceVars.data if v.attributes.key == var.key && v.attributes.category == var.category {v}]
			if len(varsFound) > 0 {
				variable_id: varsFound[0].id
				method:      "PATCH"
				url:         "https://\(cloud.hostname).com/api/v2/workspaces/\(workspace.id)/vars/\(variable_id)"
			}
			if len(varsFound) == 0 {
				method: "POST"
				url:    "https://\(cloud.hostname)/api/v2/workspaces/\(workspace.id)/vars"
			}
			request: {
				body: json.Marshal({data: {type: "vars", attributes: var & {description: "configured by terraform_tool.cue"}}})
				header:
				{
					"Content-Type":  "application/vnd.api+json"
					"Authorization": "Bearer \(tfrc.token)"
				}
			}
			response: {
				statusCode: 200 | 201
			}
		}
	}
}
