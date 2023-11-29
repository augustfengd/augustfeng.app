import (
	"path"
	"strings"
)

#schema: [filename=string]: {
	#exceptions: #title: {
		_exceptions: {
			"/home/augustfengd/repositories/gh/augustfengd/augustfeng.app/apps/blog/content/articles/command-line-completion-frameworks.org": "Command-Line Completion Frameworks"
			"/home/augustfengd/repositories/gh/augustfengd/augustfeng.app/apps/blog/content/articles/borrowing-battles-in-rust.org":          "Borrowing Battles in Rust"
		}
		for k, v in _exceptions {
			if filename == k {
				"title": v
			}
		}
	}
}

#schema: [filename=string]: {
	#exceptions: #title: {}
	"filename": filename
	{
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
	} | {
		#exceptions.#title
	}
	taxonomies: [taxonomy=string]: [...string]
}

#schema
