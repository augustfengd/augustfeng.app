(require 'org-element)

(defun article/taxonomy (taxonomy terms)
  (let ((table (make-hash-table :test #'equal)))
    (puthash taxonomy terms table)
    table))

(defun article (filename title taxonomies)
  (let ((table (make-hash-table :test #'equal)))
    (puthash "filename" filename table)
    (puthash "title" title table)
    (puthash "taxonomies" taxonomies table)
    table))

(defun example-hash-table ()
  (let ((table (make-hash-table :test #'equal))
        (make-taxonomy (lambda (taxonomy terms) (let ((table (make-hash-table :test #'equal)))
                                                  (puthash taxonomy terms table)
                                                  table)))
        (make-article (lambda (filename title taxonomies) (let ((table (make-hash-table :test #'equal)))
                                                            (puthash "filename" filename table)
                                                            (puthash "title" title table)
                                                            (puthash "taxonomies" taxonomies table)
                                                            table))))
    (puthash "/home/augustfengd/repositories/gh/augustfengd/augustfeng.app/apps/blog/content/articles/configure-guile.org"
             (apply make-article (list "configure-guile.org"
                                       "configure guile"
                                       (apply make-taxonomy (list "categories" ["ssfoo" "bar"])))) table)
    (puthash "/home/augustfengd/repositories/gh/augustfengd/augustfeng.app/apps/blog/content/articles/change-the-direction-of-incremental-searching-in-a-shell.org"
             (apply make-article (list "change-the-direction-of-incremental-searching-in-a-shell.org"
                                       "Change the Direction of Incremental Searching in a Shell"
                                       (apply make-taxonomy (list "categories" ["fffoo" "bar"])))) table)
    table))

;; ---

(defun git (args)
  (with-output-to-string (with-current-buffer standard-output
                           (apply #'call-process "git" nil t nil args)
                           (delete-backward-char 1))))

(defun find-blog-content-dir ()
  (let ((git-absolute-dir (git '("rev-parse" "--show-toplevel")))
        (hugo-relative-dir "apps/blog")
        (content-relative-dir "content/articles"))
    (file-name-concat git-absolute-dir hugo-relative-dir content-relative-dir)))

(defun program ()
  (message (json-serialize (example-hash-table))))

(program)
