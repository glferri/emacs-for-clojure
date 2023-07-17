;; https://linuxhint.com/c_emacs_configuration/
;;conf for cpp

;; activate yasnippet
(require 'yasnippet)
(yas-global-mode 1)

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; flycheck reporting errors and warnings
(use-package auto-complete
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; C++ modern
(add-hook 'c++-mode-hook #'modern-c++-font-lock-mode) 
(use-package modern-cpp-font-lock
  :ensure t)


;;we will be making use of a custom function and the GDB debugger
(defun code-compile ()
  (interactive)
  (unless (file-exists-p "Makefile")
    (set (make-local-variable 'compile-command)
     (let ((file (file-name-nondirectory buffer-file-name)))
       (format "%s -o %s %s"
           (if  (equal (file-name-extension file) "cpp") "g++" "gcc" )
           (file-name-sans-extension file)
           file)))
    (compile compile-command)))

(global-set-key [f9] 'code-compile)

;;After compiling, to run the C++ file, hit Alt + x and enter gdb

