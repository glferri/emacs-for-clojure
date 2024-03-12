;; -*- lexical-binding: t; -*-
;; Emacs comes with package.el for installing packages.
;; Try M-x list-packages to see what's available.
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)


;;set default directory system independent
;;first we set a new variable we use throughout, then we change default directory in the end
(setq custom-user-doc-directory (if (eq nil (getenv "USERPROFILE")) "~"
			  (concat  (string-replace "\\" "/" (getenv "USERPROFILE"))  "/Documents/")))



;; setup.el provides a macro for configuration patterns
;; it makes package installation and config nice and tidy!
;; https://www.emacswiki.org/emacs/SetupEl
(if (package-installed-p 'setup)
    nil
  (if (memq 'setup package-archive-contents)
      nil
    (package-refresh-contents))
  (package-install 'setup))
(require 'setup)

;; GF20240312 it seems use-package is the new way to go
;; TODO: this configuration used setup.el, we should subsitute with use-package everywhere
;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package))



;; All other features are loaded one by one from
;; the customizations directory. Read those files
;; to find out what they do.
(add-to-list 'load-path "~/.emacs.d/customizations")

(defvar addons
  '("ui.el"
    "navigation.el"
    "projects.el"
    "git.el"
    "filetree.el"
    "editing.el"
    "elisp-editing.el"
    "setup-code.el"
    "setup-clojure.el"
    "setup-js.el"
    "shell-integration.el"
    "setup-org.el"
    "spell-checkers.el"
    "setup-org-roam.el"
))

(dolist (x addons)
  (load x))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

;; set default dir now
(setq default-directory custom-user-doc-directory)
