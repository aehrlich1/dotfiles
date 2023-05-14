;; -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defun ae/counsel-rg-preview-advice (orig-fun &rest args)
  (minibuffer-with-setup-hook
      (lambda () (setq ivy-calling t))
    (apply orig-fun args)))

(defun ae/counsel-rg ()
    (interactive)
    (counsel-rg nil default-directory))

(defun browse-file-directory ()
  (interactive)
  (browse-url-of-file (expand-file-name default-directory)))

(setq mac-command-modifier 'meta)
(setq mac-right-option-modifier nil)
(add-to-list 'initial-frame-alist '(font . "Fira Code-11.5"))
(add-to-list 'default-frame-alist '(font . "Fira Code-11.5"))

(setq default-directory "~/Dropbox/emacs/")
(setq user-emacs-directory "~/.config/emacs/.emacs.d/")
(setq custom-file (concat user-emacs-directory "custom.el"))
(setq inhibit-startup-screen t)
(setq ring-bell-function 'ignore)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq initial-scratch-message 'nil)
(setq inhibit-startup-echo-area-message "Anatol")
(setq default-process-coding-system '(utf-8 . utf-8))
(setq initial-major-mode 'org-mode)
(setq align-to-tab-stop nil)
(setq dired-kill-when-opening-new-dired-buffer t)
(setq help-window-select t)
(setq-default truncate-lines t)
(setq-default display-line-numbers-width 3)
(setq-default buffer-file-coding-system 'utf-8)
(setq-default default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8 )
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(show-paren-mode +1)
(delete-selection-mode +1)
(blink-cursor-mode 0)
(global-hl-line-mode +1)
(global-auto-revert-mode +1)
;(global-visual-line-mode +1)
(global-display-line-numbers-mode)
(global-set-key (kbd "C-M-p") (lambda () (interactive) (scroll-down 2)))
(global-set-key (kbd "C-M-n") (lambda () (interactive) (scroll-up 2)))
(global-unset-key (kbd "C-x C-c"))
(global-set-key (kbd "C-x ESC") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-x r l") 'bookmark-jump)

(use-package counsel
  :ensure t
  :config
  (advice-add 'counsel-rg :around #'ae/counsel-rg-preview-advice)  
  :bind
  ("C-h b"   . counsel-descbinds)
  ("C-h a"   . counsel-apropos))

(use-package corfu
  :ensure t
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.3)
  (corfu-auto-prefix 1)
  :bind
  ((:map corfu-map)
   ("RET" . nil))  
  :init
  (global-corfu-mode))

(use-package deft
  :ensure t
  :after org
  :bind
  ("<f2>" . deft)
  :custom
  (deft-recursive t)
  (deft-use-filter-string-for-filename t)
  (deft-default-extension "org")
  (deft-directory org-roam-directory))

(use-package doom-modeline
  :ensure t
  :custom-face
  (mode-line ((t (:box nil))))
  (mode-line-inactive ((t (:box nil))))
  :init
  (doom-modeline-mode)
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-height 25))

(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package org
  :custom-face
  (org-meta-line ((t (:inherit 'font-lock-comment-face))))
  :custom
  (org-src-tab-acts-natively t)
  (org-cycle-separator-lines 2)
  (org-cycle-open-archived-trees t)
  (org-ascii-text-width 80)
  (org-catch-invisible-edits 'error)
  (org-src-window-setup 'current-window)
  (org-todo-repeat-to-state "NEXT")
  (org-startup-indented t)
  (org-bookmark-names-plist nil)
  (org-indent-indentation-per-level 2)
  (org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "WHIP" "|" "DONE(d)" "KILL(k)")))
  (org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+")))
  (org-blank-before-new-entry '((heading . auto) (plain-list-item . nil)))
  (org-refile-use-outline-path 'file)
  (org-outline-path-complete-in-steps nil)
  (org-todo-keyword-faces
   '(("TODO" . org-todo)
     ("NEXT" . "#008080")
     ("PROG" . "#1e90ff")
     ("WAIT" . "orange")
     ("DONE" . org-done)
     ("WHIP" . "pink")
     ("KILL" . "#F1420B")))
  :bind
  (("C-c l"   . org-store-link)
   (:map org-mode-map)
   ("C-x C-x" . org-edit-special)
   ("C-c e"   . org-table-edit-field)
   ("M-l"     . org-metaright)
   ("M-h"     . org-metaleft)
   ("M-k"     . org-metaup)
   ("M-j"     . org-metadown)
   ("C-c C-q" . counsel-org-tag)
   (:map org-src-mode-map)
   ("C-x C-x" . org-edit-src-exit)))

(use-package org-agenda
  :init
  (add-hook 'org-agenda-mode-hook 'org-super-agenda-mode)
  :requires org-super-agenda
  :config
  (setq org-agenda-window-setup 'current-window)
  (setq org-agenda-files '("~/Dropbox/emacs" "~/Dropbox/emacs/roam" "~/Dropbox/emacs/roam/daily"))
  (setq org-agenda-span 1)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 5)
  (setq org-agenda-show-inherited-tags nil)
  (setq org-agenda-block-separator nil)
  (setq org-agenda-compact-blocks t)
  (setq org-agenda-log-mode-items '(closed))
  (setq org-agenda-text-search-extra-files '(agenda-archives))
  (setq org-agenda-deadline-faces
	'((1.0 . org-upcoming-deadline)
	  (0.5 . org-upcoming-deadline)
	  (0.0 . org-upcoming-deadline)))
  (setq org-agenda-prefix-format
	'((agenda . " %i %-12:c%?-12t%-12s")
	  (todo . " %i %-12:c")
	  (tags . " %i %-12:c")
	  (search . " %i %-12:c")))
  :bind
  (("C-c a" . org-agenda)))

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/Dropbox/emacs/roam")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
   '(("d" "default" entry "* %<%H:%M> %?"
      :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind
  (("C-c n l" . org-roam-buffer-toggle)
   ("C-c n f" . org-roam-node-find)
   ("C-c n i" . org-roam-node-insert)
   :map org-mode-map
   ("C-M-i"   . completion-at-point)
   :map org-roam-dailies-map
   ("y" . org-roam-dailies-capture-yesterday)
   ("c" . org-roam-dailies-capture-today)
   ("t" . org-roam-dailies-capture-tomorrow))
  :bind-keymap
  ("C-d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-setup))

(use-package org-roam-ui
  :ensure t
  :after org-roam
  :custom
  (org-roam-ui-sync-theme t)
  (org-roam-ui-follow t)
  (org-roam-ui-update-on-save t)
  (org-roam-ui-open-on-start t))

(use-package org-tempo)

(use-package savehist
  :init
  (savehist-mode))

(use-package swiper
  :ensure t
  :bind
  ("C-h C-s" . swiper))

(use-package vertico
  :ensure t
  :init
  (vertico-mode)
  :custom
  (vertico-cycle t))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package zenburn-theme
  :ensure zenburn-theme
  :config
  (load-theme 'zenburn t))

