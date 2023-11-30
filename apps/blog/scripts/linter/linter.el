(require 'org-element)

;; system operations

(defun git (args)
  (with-output-to-string (with-current-buffer standard-output
                           (apply #'call-process "git" nil t nil args)
                           (delete-backward-char 1))))

(defun find-blog-content-dir ()
  (let ((git-absolute-dir (git '("rev-parse" "--show-toplevel")))
        (blog-relative-dir "apps/blog")
        (content-relative-dir "content"))
    (file-name-concat git-absolute-dir blog-relative-dir content-relative-dir)))

(defun get-article-filepaths ()
  (let ((files (directory-files-recursively (find-blog-content-dir) "org$")))
    (seq-remove (lambda (s) (string-prefix-p ".#" s)) files)))

;; data operations

(defun parse-file (file)
  (with-temp-buffer
    (insert-file-contents file)
    (org-element-parse-buffer)))

(defun add-keyword (keyword keywords)
  (let ((key (org-element-property :key keyword))
        (value (org-element-property :value keyword)))
    (puthash key (cons value (gethash key table)) keywords)))

(defun build-keywords (ast)
  (let ((table (make-hash-table :test #'equal)))
    (org-element-map ast 'keyword (lambda (keyword) (add-keyword keyword table)))
    (maphash (lambda (key value) (puthash key (reverse (apply #'vector value)) table)) table)
    table))

(defun build-front-matter (keywords)
  (let ((table (make-hash-table :test #'equal))
        (taxonomies (make-hash-table :test #'equal)))
    (maphash (lambda (key value)
               (cond ((string-equal key "TITLE") (puthash "title" (mapconcat #'identity value) table))
                     ((not nil) (puthash key value taxonomies)))) keywords)
    (puthash "taxonomies" taxonomies table)
    table))

(defun build-article-data (file)
  (let ((table (make-hash-table :test #'equal))
        (ast (parse-file file)))
    (build-front-matter (build-keywords ast))))

;; program

(defun program ()
  (let ((table (make-hash-table :test #'equal))
        (files (get-article-filepaths)))
    (mapc (lambda (file) (puthash file (build-article-data file) table)) files)
    (princ (json-serialize table))))

(provide 'linter)
