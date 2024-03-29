;;; Org configuration

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; org agenda files (get todos from all my org files recursively)
(setq org-agenda-files (directory-files-recursively (concat custom-user-doc-directory "/org-files/") "\\.org$"))




;;following https://hugocisneros.com/org-config/

;; setup keywords 
(setq org-todo-keywords
    (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))

;; cannot set done if children are not done
(setq-default org-enforce-todo-dependencies t)

;; show TODOs in different colors based on priority
(setq org-priority-faces '((?A . (:foreground "#ff4444" :weight 'bold))
                           (?B . (:foreground "#dddd44"))
                           (?C . (:foreground "#44cc44"))))


;;setup superstar
;;; Titles and Sections
;; hide #+TITLE:
(setq org-hidden-keywords '(title))


(with-eval-after-load 'org-faces 
  ;; set basic title font
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8 :foreground "#2843FB")
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8 :foreground "#ABABFF")
  ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2 :foreground "#5E65CC") ;\large
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44 :foreground "#A382FF") ;\Large
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728 :foreground "#BEA4DB") ;\LARGE
  ;; Only use the first 4 styles and do not cycle.
  (setq org-cycle-level-faces nil)
  (setq org-n-level-faces 4)
  ;; Document Title, (\huge)
  (set-face-attribute 'org-document-title nil
                      :height 2.074
                      :foreground 'unspecified
                      :inherit 'org-level-8)
  )

;;; Basic Setup
;; Auto-start Superstar with Org
(add-hook 'org-mode-hook
          (lambda ()
            (org-superstar-mode 1)))





;;latex export source-code highlighting
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted) 

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (latex . t)))

;; TODO: maybe this helps fixing latex not working
;; Making emacs find latex (so that C-c C-x C-l works on orgmode)
;;(setenv "PATH" (concat ":/Library/TeX/texbin/" (getenv "PATH")))
;;(add-to-list 'exec-path "/Library/TeX/texbin/")


(setq org-preview-latex-process-alist  '((dvipng :programs
                                                ("latex" "dvipng")
                                                :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
                                                (1.0 . 1.0)
                                                :latex-compiler
                                                ("latex -shell-escape -interaction nonstopmode -output-directory %o %f")
                                                :image-converter
                                                ("dvipng -D %D -T tight -o %O %f")
                                                :transparent-image-converter
                                                ("dvipng -D %D -T tight -bg Transparent -o %O %f"))
                                        (dvisvgm :programs
                                                 ("latex" "dvisvgm")
                                                 :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
                                                 (1.7 . 1.5)
                                                 :latex-compiler
                                                 ("latex -shell-escape -interaction nonstopmode -output-directory %o %f")
                                                 :image-converter
                                                 ("dvisvgm %f --no-fonts --exact-bbox --scale=%S --output=%O"))
                                        (imagemagick :programs
                                                     ("latex" "convert")
                                                     :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :image-input-type "pdf" :image-output-type "png" :image-size-adjust
                                                     (1.0 . 1.0)
                                                     :latex-compiler
                                                     ("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")
                                                     :image-converter
                                                     ("convert -density %D -trim -antialias %f -quality 100 %O"))))

