package github

// NOTE: this will close the jobs structure, thus giving us constraints.
// NOTE: ... actually in retrospect, I've no idea what's going on but it works.
X=#Workflow: #Jobs: X.jobs
#Workflow: #Job:    (#Workflow.#Jobs & {x: _}).x

Y=#Workflow: #Steps: (Y.jobs & {x: {steps: _}}).x.steps
#Workflow: #Step:    (#Workflow.#Steps & [_])[0]
