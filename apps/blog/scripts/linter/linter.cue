import (
	"path"
	"strings"
	"list"
)

#blog_dir: string @tag(blog_dir)

#schema: [filename=string]: {
	#exceptions: titles: {
		"\(#blog_dir)/content/articles/command-line-completion-frameworks.org":                                         "Command-Line Completion Frameworks"
		"\(#blog_dir)/content/articles/borrowing-battles-in-rust.org":                                                  "Borrowing battles in Rust"
		"\(#blog_dir)/content/articles/a-study-of-newtype-usage-in-rust.org":                                           "A study of newtype usage in Rust"
		"\(#blog_dir)/content/articles/using-srtp.org":                                                                 "Using SRTP"
		"\(#blog_dir)/content/articles/uncovering-iptables-in-gke.org":                                                 "Uncovering iptables in GKE"
		"\(#blog_dir)/content/articles/rebasing-after-squash-and-merge-on-github.org":                                  "Rebasing after squash and merge on GitHub"
		"\(#blog_dir)/content/articles/opening-emacs-from-windows.org":                                                 "Opening Emacs from windows"
		"\(#blog_dir)/content/articles/linked-lists-for-fun-in-rust.org":                                               "Linked lists for fun in Rust"
		"\(#blog_dir)/content/articles/learning-rust-iterators.org":                                                    "Learning Rust iterators"
		"\(#blog_dir)/content/articles/keeping-a-linear-history-with-github-actions.org":                               "Keeping a linear history with GitHub Actions"
		"\(#blog_dir)/content/articles/implementing-the-read-trait.org":                                                "Implementing the Read trait"
		"\(#blog_dir)/content/articles/environment-variables-and-volumes-when-building-images-with-docker-compose.org": "Environment variables and volumes when building images with Docker Compose"
		"\(#blog_dir)/content/articles/exploring-org-agenda-workflows.org":                                             "Exploring org-agenda workflows"
		"\(#blog_dir)/content/articles/digests-from-docker-manifests.org":                                              "Digests from Docker manifests"
		"\(#blog_dir)/content/articles/debugging-spacemacs-packages.org":                                               "Debugging Spacemacs packages"
		"\(#blog_dir)/content/articles/debugging-the-jka-compr-package.org":                                            "Debugging the jka-compr package"
		"\(#blog_dir)/content/articles/consuming-upstream-themes-in-hugo.org":                                          "Consuming upstream themes in Hugo"
		"\(#blog_dir)/content/articles/configure-macos.org":                                                            "Configure MacOS"
		"\(#blog_dir)/content/articles/configure-jetbrains.org":                                                        "Configure JetBrains"
		"\(#blog_dir)/content/articles/configure-guile.org":                                                            "Configure Guile"
		"\(#blog_dir)/content/articles/compiling-emacs.org":                                                            "Compiling Emacs"
		"\(#blog_dir)/content/articles/configure-emacs.org":                                                            "Configure Emacs"
		"\(#blog_dir)/content/articles/latex.org":                                                                      "LaTeX"
		"\(#blog_dir)/content/articles/moonlander-and-xhci.org":                                                        "Moonlander and xHCI"
	}
}

#schema: [filename=string]: {
	#exceptions: titles: {}

	#isException: list.Contains([ for it, _ in #exceptions.titles {it}], filename)

	if !#isException {
		title: {
			let a = path.Base(filename, path.Unix)
			let b = path.Ext(filename, path.Unix)
			let c = strings.TrimSuffix(a, b)
			let d = strings.Replace(c, "-", " ", -1)
			let e = strings.SliceRunes(d, 0, 1)
			let f = strings.SliceRunes(d, 1, len(d))
			let g = strings.ToUpper(e)
			g + f
		}
	}

	if #isException {
		title: #exceptions.titles[filename]
	}
	taxonomies: {
		"CATEGORIES": [ ...{"programming" | "emacs" | "configuration" | "scripting" | "kubernetes" | "containers" | "project" | "web"}] & list.UniqueItems
		"TAGS":       [ ...{"fsharp" | "rust" | "go" | "jsonnet" | "cue" | "emacs-lisp" | "scheme" | "guile" | "cpp" | "latex" | "github" | "hugo" | "dotnet" | "kubernetes" | "linux" | "windows" | "wsl2" | "org-mode" | "git" | "shell" | "helm" | "docker" | "shortcuts" | "cicd" | "documentation" | "jetbrains"}] & list.UniqueItems
		...
	}
}

#schema
