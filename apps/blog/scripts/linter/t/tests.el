(require 'linter)

(defun data ()
  (with-temp-buffer
    (insert (mapconcat #'identity '("#+title: lint test data" "#+categories: foo" "#+categories: bar" "#+categories: baz") "\n"))
    (org-element-parse-buffer)))

(ert-deftest build-taxonomies-test ()
  (let ((expected (let ((table (make-hash-table :test #'equal)))
                    (puthash "TITLE" ["lint test data"] table)
                    (puthash "CATEGORIES" ["foo" "bar" "baz"] table)
                    table))
        (actual (build-keywords (data))))
    (should (equal (gethash "TITLE" actual)
                   (gethash "TITLE" expected)))
    (should (equal (gethash "CATEGORIES" actual)
                   (gethash "CATEGORIES" expected)))))
