;;; Emacs customization -*- mode: emacs-lisp; outline-regexp: ";;;;*" -*-
;; Nitin Chandrachoodan (nitin@ee.iitm.ac.in) 

;;; General settings
(global-font-lock-mode t)		; syntax highlighting
;; (display-time)				; display time and load
;; (display-battery-mode)			; battery status: laptop
;; (column-number-mode t)			; duh
(tool-bar-mode)				; toggle: turn OFF toolbar
(menu-bar-mode)				; toggle: turn OFF menubar
(set-scroll-bar-mode nil) 		; no side scroll bar
(setq-default transient-mark-mode t)	; highlight 'region'
(setq require-final-newline t)		; auto insert newline at EOF
(setq next-line-add-newlines nil)	; stop at end of file
(cond (window-system			; Enable wheelmouse support 
       (mwheel-install)))
(if (display-mouse-p) 			; see the mouse run!
    (mouse-avoidance-mode 'animate)) 
(fset 'yes-or-no-p 'y-or-n-p)		; yes-or-no too long
(setq mail-host-address "ee.iitm.ac.in") ; system mail-host explicit
(setq backup-directory-alist 		; centralized backups
      '(("." . "~/.emacs.d/backup")))
(setq default-frame-alist '((width . 100) (height . 36)))
(setq work-dir "~/work/")		; Base directory for all
;; Load all relevant files
;(setq el-dir "~/work/admin/setup/elisp/")
;(add-to-list 'load-path el-dir)
;(add-to-list 'load-path (concat el-dir "org-mode/lisp"))
;(add-to-list 'load-path (concat el-dir "relax.el"))
; (add-to-list 'load-path (concat el-dir "remember-1.9"))
(defun ffe ()
  "Open the emacs config file for editing"
  (interactive)
  (find-file "~/work/admin/setup/emacs.el"))
;; Emacs server
(server-start)

;;; keybindings
(global-set-key '[f3] 'ffap)
(global-set-key '[(shift f3)] 'dired)
;(global-set-key '[f4] 'speedbar-get-focus)
;(global-set-key '[f5] 'outline-minor-mode)
(global-set-key '[f6] 'other-window)
(global-set-key '[f8] 'kill-buffer)
;(global-set-key '[f9] 'compile)
(global-set-key '[f9] 'server-edit)
(global-set-key '[(shift f9)] 'eval-region)
(global-set-key '[(shift f10)] 'eshell)
(global-set-key '[f11] 'electric-buffer-list)
(global-set-key '[f12] 'menu-bar-open)
(global-set-key "\C-z" 'delete-other-windows)
(define-key global-map [(shift mouse-3)] 'imenu) ; imenu for subject popup 
(global-set-key (kbd "<insert>") nil)	; blasted insert key

;;; autofill -- dumped filladapt
(add-hook 'text-mode-hook
          (function (lambda ()
                      (turn-on-auto-fill)
                      )))

;;; allout outline mode
;(require 'allout)
;(allout-init t)

;;; irritated with tabs and spaces. just use spaces?
(setq c-basic-offset 4)
; (setq tab-width 4)
; (setq indent-tabs-mode nil)

; enable auctex and preview-latex style?
;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)
(setq TeX-PDF-mode t)                      ;turn on PDF mode.


;;; RefTeX -- God mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)
(setq reftex-extra-bindings t)
(setq reftex-label-alist
      '(("slide"   ?l "sl:"  "~\\ref{%s}" 1 ("slide"   "sl.") 2)
	))
(setq reftex-use-external-file-finders t)
(setq reftex-external-file-finders
      '(("tex" . "kpsewhich -format=.tex %f")
	("bib" . "kpsewhich -format=.bib %f")))

;;; beamer support: http://lists.gnu.org/archive/html/auctex/2006-01/msg00023.html
(eval-after-load "tex"
  '(TeX-add-style-hook "beamer" 'my-beamer-mode))

(setq TeX-region "regionsje")
(defun my-beamer-mode ()
  "My adds on for when in beamer."

  ;; when in a Beamer file I want to use pdflatex.
  ;; Thanks to Ralf Angeli for this.
  (TeX-PDF-mode 1)                      ;turn on PDF mode.

  ;; Tell reftex to treat \lecture and \frametitle as section commands
  ;; so that C-c = gives you a list of frametitles and you can easily
  ;; navigate around the list of frames.
  ;; If you change reftex-section-level, reftex needs to be reset so that
  ;; reftex-section-regexp is correctly remade.
  (require 'reftex)
  ;; (set (make-local-variable 'reftex-section-levels)
  ;;      '(("lecture" . 1) ("frametitle" . 2)))
  (set (make-local-variable 'reftex-section-levels)
       '(("section" . 1) ("subsection" . 2) ("frametitle" . 3)))
  (reftex-reset-mode)

  ;; add some extra functions.
  (define-key LaTeX-mode-map "\C-cf" 'beamer-template-frame)
  (define-key LaTeX-mode-map "\C-\M-x" 'tex-frame)
)

(defun tex-frame ()
  "Run pdflatex on current frame.  
Frame must be declared as an environment."
  (interactive)
  (let (beg)
    (save-excursion
      (search-backward "\\begin{frame}")
      (setq beg (point))
      (forward-char 1)
      (LaTeX-find-matching-end)
      (TeX-pin-region beg (point))
      (letf (( (symbol-function 'TeX-command-query) (lambda (x) "LaTeX")))
        (TeX-command-region))
        )
      ))


(defun beamer-template-frame ()
  "Create a simple template and move point to after \\frametitle."
  (interactive)
  (LaTeX-environment-menu "frame")
  (insert "\\frametitle{}")
  (backward-char 1))

;;; Spice mode
(autoload 'spice-mode "spice-mode" "Spice/Layla Editing Mode" t)
(setq auto-mode-alist (append (list (cons "\\.sp$" 'spice-mode)
                                    (cons "\\.cir$" 'spice-mode)
                                    (cons "\\.ckt$" 'spice-mode)
                                    (cons "\\.mod$" 'spice-mode)
                                    (cons "\\.cdl$" 'spice-mode)
                                    (cons "\\.chi$" 'spice-mode) ;eldo outpt
                                    (cons "\\.inp$" 'spice-mode))
                              auto-mode-alist))


;;; calendar, diary, appointments 
(setq calendar-latitude 13.0)
(setq calendar-longitude 83.0)
(setq calendar-location-name "Chennai, India")
(require 'appt)
(setq mark-diary-entries-in-calendar nil 
      view-diary-entries-initially nil 	
      calendar-remove-frame-by-deleting t
      mark-holidays-in-calendar t
      today-visible-calendar-hook 'calendar-mark-today
      diary-file "~/work/admin/diary"
      european-calendar-style t
      diary-list-include-blanks t
      calendar-setup nil 		; just use the current frame
      )
(setq general-holidays nil		; Indian holidays
      christian-holidays nil
      islamic-holidays nil
      hebrew-holidays nil)
(setq local-holidays 
      '((holiday-fixed 1 1 "New Years Day")
	(holiday-fixed 8 15 "Independence Day")
	(holiday-fixed 1 26 "Republic Day")
	(holiday-fixed 10 2 "Gandhi Jayanthi")
	(holiday-fixed 4 14 "Ambedkar's birthday")
	(holiday-fixed 12 25 "Christmas")))
(setq other-holidays ;; not really fixed, just lazy
      '((holiday-fixed 4 9 "Good Friday")
	(holiday-fixed 4 13 "Vishu/Tamil New Year")))
(setq list-diary-entries-hook
      '(include-other-diary-files sort-diary-entries))
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'diary-display-hook 'sort-diary-entries)
;; (load-library "cal-desk-calendar")
;; (add-hook 'diary-display-hook 'fancy-schedule-display-desk-calendar t)
(add-hook 'calendar-move-hook (lambda () (view-diary-entries 1)))

;;; FIXME - Verilog mode - is this needed?
;(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;(setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
;(setq auto-mode-alist (cons  '("\\.dv\\'" . verilog-mode) auto-mode-alist))
;;; Nvidia .cu files -- use c++ mode
(setq auto-mode-alist (cons  '("\\.cu\\'" . c++-mode) auto-mode-alist))
;;; Matlab .m files -- use octave mode
(setq auto-mode-alist (cons  '("\\.m\\'" . octave-mode) auto-mode-alist))

;;; Config for org from source and others
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key '[f4] 'org-capture)
(global-set-key '[f5] 'org-agenda)
(global-set-key '[(control f5)] 'org-todo-list)

(setq org-directory (concat work-dir "admin/org/"))
(setq org-default-notes-file (concat org-directory "notes.org"))
(setq org-hide-leading-stars t)
; (setq org-startup-indented t)
; (setq org-odd-levels-only t)
(setq org-todo-keywords 
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "DEFERRED(e)")
	(sequence "|" "CANCELED(c)")))
(setq org-use-fast-todo-selection t)
(setq org-log-done '(state))
(eval-after-load "org"
  '(progn
     (define-key org-mode-map "\C-n" 'org-next-link) 
     (define-key org-mode-map "\C-p" 'org-previous-link)
     (define-key org-mode-map '[f7] 'org-archive-to-archive-sibling)
     (global-set-key "\C-cL" 'org-insert-link-global)
     (global-set-key "\C-co" 'org-open-at-point-global)))
(defun foo ()
  "File Open Org!"
  (interactive)
  (find-file "~/work/admin/org/TODO.org"))

(defun nitin-preamble-insert () 
  "Insert a preamble for org-publish HTML site."
  (with-temp-buffer (insert-file-contents-literally "~/git/website/pages/preamble.html") 
					(buffer-string))
  )
(defun nitin-postamble-insert () 
  "Insert a postamble for org-publish HTML site."
  (with-temp-buffer (insert-file-contents-literally "~/git/website/pages/postamble.html") 
					(buffer-string))
  )

(setq org-export-html-preamble (nitin-preamble-insert))
(setq org-export-html-postamble (nitin-postamble-insert))
(require 'org-publish)
(setq org-publish-project-alist
      '(("nitin-site"
         :components ("site-content" "site-static"))
        ("site-content"
         :base-directory "~/git/website/pages/"
         :base-extension "org"
         :publishing-directory "~/public_html"
         :recursive t
         :publishing-function org-publish-org-to-html
         :export-with-tags nil
         :headline-levels 4             ; Just the default for this project.
         :table-of-contents nil
         :section-numbers nil
         :sub-superscript nil
         :todo-keywords nil
         :author nil
         :creator-info nil
;		 :html-preamble '(lambda () "nitin-preamble-insert")
;         :html-postamble "<div id=\"footer\"> &copy; Nitin Chandrachoodan 2013.  Theme adapted from <a href=\"http://orderedlist.com/modernist/\">Modernist</a></div>"
         :style "<script src=\"/~nitin/static/js/bootstrap.min.js\"></script>\n\
<link rel=\"stylesheet\" href=\"/~nitin/static/css/bootstrap.css\" type=\"text/css\"/>\n\
<link rel=\"stylesheet\" href=\"/~nitin/static/modernist.css\" type=\"text/css\"/>"
         :timestamp t
         :exclude-tags ("noexport" "todo")
         :auto-preamble nil)
        ("site-static"
         :base-directory "~/git/website/static/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|otf"
         :publishing-directory "~/public_html/static/"
         :recursive t
         :publishing-function org-publish-attachment)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(org-agenda-custom-commands (quote (("n" "Next action items" todo #("NEXT" 0 4 (face org-warning)) nil) ("w" "Waiting items" todo #("WAITING" 0 7 (face org-warning)) nil) ("c" "Completed (Done or Deferred)" todo #("DONE|DEFERRED" 0 13 (face org-warning)) nil))))
 '(org-agenda-files (quote ("~/work/current/aura/aura.org" "~/work/admin/org/TODO.org" "~/work/admin/org/JOURNAL.org")))
 '(org-agenda-start-on-weekday nil)
 '(org-attach-directory "~/annex")
 '(org-capture-templates (quote (("t" "Todo" entry (file+headline "~/work/admin/org/TODO.org" "Tasks") "* TODO %?
  OPENED: %U
 %i
") ("r" "Reference" entry (file+headline "~/work/admin/org/refs.org" "Refs") "* TODO %U %?

 %i
") ("j" "Journal" entry (file+headline "~/work/admin/org/journal.org" "Journal") "* %^{Title} %U
  %?

 %i
") ("i" "Idea" entry (file+headline "~/work/admin/org/journal.org" "New Ideas") "* %^{Title}
 %i
"))))
 '(safe-local-variable-values (quote ((TeX-master . "paper.tex") (TeX-master . "paper"))))
 '(tab-width 4)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "apple" :family "Monaco")))))

;;; ChangeLog
;; $Log: emacs.el,v $
;; Revision 1.4  2012/02/13 14:37:33  nitin
;; tab killing. switching to spaces.
;;
;; Revision 1.3  2010/11/09 15:29:56  nitin
;; Update to org7.3, replace remember with capture.
;;
;; Revision 1.2  2007/12/28 14:40:08  nitin
;; Moved to new structure inside work directory
;;
