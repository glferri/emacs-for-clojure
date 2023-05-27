;; Sets up exec-path-from shell
;; https://github.com/purcell/exec-path-from-shell
(setup 
  (when (memq window-system '(mac ns))
    (:package exec-path-from-shell)
    (exec-path-from-shell-initialize)))

;; load w32-browser

(add-to-list 'package-pinned-packages '(w32-browser . "melpa-stable") t)
(setup (:package w32-browser))
  ;; (:global "C-M-;" magit-status))

;; it doesn't load package from melpa, why?
;; (setup
     ;; (when (memq window-system '(w32))
       ;; (:package w32-browser)
;; ))



;;it gives me errors
;; (defun browse-file-directory ()
;;   "Open the current file's directory however the OS would."
;;   (interactive)
;;   (if default-directory
;;       (browse-url-of-file (expand-file-name default-directory))
;;     (error "No `default-directory' to open")))
