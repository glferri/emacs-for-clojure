;; following https://www.tenderisthebyte.com/blog/2019/06/09/spell-checking-emacs/#:~:text=The%20basic%20way%20to%20do,back%20to%20the%20default%20dictionary.

;;; still not working, we could try installing hunspell

(add-to-list 'exec-path "C:/Users/gferri/scoop/apps/msys2/current/usr/bin/")
(setq ispell-program-name "aspell")
;; enable flyspell
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))



