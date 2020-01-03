(fset 'yes-or-no-p 'y-or-n-p)

(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosave/" t)))
(setq auto-save-list-file-prefix "~/.emacs.d/autosave/")
(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")))
(setq browse-url-browser-function 'browse-url-xdg-open)
(setq delete-old-versions t)
(setq gc-cons-threshold 50000000)
(setq inhibit-startup-screen t)
(setq line-number-display-limit-width 10000)
(setq mouse-yank-at-point t)
(setq org-agenda-files '("~/org"))
(setq save-interprogram-paste-before-kill t)
(setq version-control t)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))

;; Indent with spaces by default
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(defun my-quit-emacs-unconditionally ()
  (interactive)
  (my-quit-emacs '(4)))

(define-key special-event-map (kbd "<sigusr1>") 'my-quit-emacs-unconditionally)

(defun my-yank-primary ()
  (interactive)
  (let ((primary (or (x-get-selection-value)
                     (x-get-selection))))
    (unless primary
      (error "No selection is available"))
    (push-mark (point))
    (insert-for-yank primary)))

(global-set-key (kbd "<S-insert>") 'my-yank-primary)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; style I want to use in c++ mode
(c-add-style "my-style" 
	     '("stroustrup"
	       (indent-tabs-mode . nil)
	       (c-basic-offset . 4)
	       (c-offsets-alist . ((inline-open . 0)
				   (brace-list-open . 0)
				   (statement-case-open . +)))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; line numbers
(global-linum-mode 1)
;; flycheck
(when (load "flycheck" t t)
  (global-flycheck-mode 1))
;; ivy
(ivy-mode 1)

(put 'dired-find-alternate-file 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
    ("80ae3a89f1eca6fb94a525004f66b544e347c6f756aaafb728c7cdaef85ea1f5" default)))
 '(ivy-mode t)
 '(package-selected-packages
   (quote
    (emojify labburn-theme markdown-mode ivy ix latex-math-preview flymake-easy flycheck cmake-mode auctex)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
