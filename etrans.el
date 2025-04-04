;;; etrans.el --- Translate text using DeepL -*- lexical-binding: t -*-

;; Author:  Dan Pomohaci
;; Version: 0.1
;; Package-Requires: ((emacs "24.4") (request "0.3.3"))
;; Homepage: https://gitlab.com/dpom/etrans
;; Keywords: text,tool

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 3, or (at your
;; option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Translate text using DeepL.

;; You need to set the etrans-deepl-auth-key in order to use this translater


;;; Code:
(require 'request)

(defgroup etrans nil
  "Customization group for etrans."
  :group 'extensions)

(defcustom etrans-deepl-auth-key ""
  "Authentication Key for DeepL API."
  :type 'string
  :group 'etrans)

(defcustom etrans-source-lang "RO"
  "Source language."
  :type 'string
  :group 'etrans)

(defcustom etrans-target-lang "EN"
  "Target language."
  :type 'string
  :group 'etrans)

(defconst etrans-languages '("RO" "EN" "FR" "DE" "ES" "JA"))

(cl-defun
    etrans-insert
    (&key
     data
     &allow-other-keys)
  (let ((translated-text (cdr (assoc 'text (aref (cdr (assoc 'translations data)) 0)))))
    (insert translated-text)))


(defun etrans-send-request (text)
  (request "https://api-free.deepl.com/v2/translate"
    :type "POST"
    :data `(("auth_key" . ,etrans-deepl-auth-key)
            ("text" . ,text)
            ("source_lang" . ,etrans-source-lang)
            ("target_lang" . ,etrans-target-lang))
    :parser 'json-read
    :success #'etrans-insert))

(defun etrans-set-source ()
  (interactive)
  (setq etrans-source-lang (completing-read "Source lang: " etrans-languages nil nil
                                            etrans-source-lang)))
(defun etrans-set-target ()
  (interactive)
  (setq etrans-target-lang (completing-read "Target lang: " etrans-languages nil nil
                                            etrans-target-lang)))

(defun etrans-translate (start end)
  (interactive "r")
  (let ((region
         (buffer-substring
          start
          end)))
    (kill-region start end)
    (etrans-send-request region)))

(provide 'etrans)

;;; etrans.el ends here
