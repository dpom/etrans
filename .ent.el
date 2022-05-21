;;; .ent.el --- local ent config file -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

;; project settings
(setq ent-project-home (file-name-directory (if load-file-name load-file-name buffer-file-name)))
(setq ent-project-name "etrans")
(setq ent-clean-regexp "~$\\|\\.tex$")
(setq ent-project-orgfile "Notebook.org")

(require 'ent)

(ent-tasks-init)

(setq make (expand-file-name "makem.sh" ent-project-home))
(setq init-opts " --install-deps --install-linters -v ")
(setq opts " -s.sandbox  -e ent.el -v ")



(task 'sandbox '() "create sandbos" '(lambda (&optional x) (concat make init-opts "-s.sandbox")))
(task 'lint '() "lint the project" '(lambda (&optional x) (concat make opts "lint")))
(task 'elsa '() "lint elsa the project" '(lambda (&optional x) (concat make opts "lint-elsa")))

(task 'test '() "test the project" '(lambda (&optional x) (concat make opts "test")))



(provide '.ent)
;;; .ent.el ends here

;; Local Variables:
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
