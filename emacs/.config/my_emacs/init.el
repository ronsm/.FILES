
(setq inhibit-startup-message t)
(setq visible-bell t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(setq scroll-step 1)

(global-display-line-numbers-mode 1) (global-visual-line-mode t)
(global-auto-revert-mode t)


;; cut startup time
;; (server-start)
;; add a if statement to fix error


(global-set-key [escape] 'keyboard-escape-quit)


(delete-selection-mode 1)
(electric-indent-mode -1)
(electric-pair-mode 1)

(set-face-attribute 'default nil :height 100)

(load-theme 'modus-vivendi t)

(setq vc-follow-symlinks nil)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; emacs startup reporting
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))


;; CLEANING EMACS CONFIG FOLDER
;; (setq user-emacs-config (expand-file-name "~/.config/emacs/"))
;;
;;(setq user-emacs-directory (expand-file-name "~/.cache/emacs/")
      ;;url-history-file (expand-file-name "url/history" user-emacs-directory))
;;
;;(setq custom-file
      ;;(if (boundp 'server-socket-dir)
          ;;(expand-file-name "custom.el" server-socket-dir)
        ;;(expand-file-name (format "emacs-custom-%s.el" (user-uid)) temporary-file-directory)))
;;(load custom-file t)
;;
;; (setq no-littering-etc-directory
      ;; (expand-file-name user-emacs-config))
;; (setq no-littering-var-directory
      ;; (expand-file-name "data/" user-emacs-directory))
;;
;; (use-package no-litering)




;; Straight - Package Manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)


;; (straight-use-package '(setup :type git :host nil :repo "https://git.sr.ht/~pkal/setup"))
;; (require 'setup)
;; 
;; (defun dw/filter-straight-recipe (recipe)
  ;; (let* ((plist (cdr recipe))
         ;; (name (plist-get plist :straight)))
    ;; (cons (if (and name (not (equal name t)))
              ;; name
            ;; (car recipe))
          ;; (plist-put plist :straight nil))))
;; 
;; (setup-define :pkg
  ;; (lambda (&rest recipe) `(straight-use-package ',(dw/filter-straight-recipe recipe)))
  ;; :documentation "Install RECIPE straight.el"
  ;; :shorthand #'cadr)



;; Evil Mode
(use-package evil
    :init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right nil)
    (setq evil-split-window-below nil)
    (evil-mode))



(use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))

(use-package evil-tutor)


;; General Keybindings

(use-package general
    :config
    (general-evil-setup)

    (general-create-definer xecarlox/leader-keys
        :states '(normal insert visual emacs)
        :keymaps 'override
        :prefix "SPC"
        :global-prefix "M-SPC")

    (xecarlox/leader-keys
      "."       '(find-file :wk "Find file")
      "c e"     '((lambda () (interactive) (find-file "~/.config/my_emacs/init.el")) :wk "Edit emacs config")
      "c l"     '((lambda () (interactive) (load-file user-init-file)) :wk "Reload emacs config")
      "f r"     '(counsel-recentf :wk "find recent files")
      "TAB TAB" '(comment-line :wk "Comment lines"))

    (xecarlox/leader-keys
      "b"   '(:ignore t          :wk "buffer")
      "b b"  '(switch-to-buffer  :wk "Switch buffer")
      "b i"  '(ibuffer           :wk "Ibuffer")
      "b k"  '(kill-this-buffer  :wk "Kill this buffer")
      "b n"  '(next-buffer       :wk "Next buffer")
      "b p"  '(previous-buffer   :wk "Previous buffer")
      "b r"  '(revert-buffer     :wk "Reload buffer"))

    (xecarlox/leader-keys
      "e" '(:ignore t :wk "Evaluate")
      "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
      "e d" '(eval-defun :wk "Evaluate defun containing or after point")
      "e e" '(eval-expression :wk "Evaluate elisp expression")
      "e h" '(counsel-esh-history :wk "Eshell history")
      "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
      "e r" '(eval-region :wk "Evaluate elisp in region")
      "e s" '(eshell :wk "Eshell")
    )

    (xecarlox/leader-keys
      "h"   '(:ignore t :wk "Help")
      "h v" '(describe-variable :wk "Describe variable")
      "h f" '(describe-function :wk "Describe function"))

    (xecarlox/leader-keys
	"t" '(:ignore t :wk "Toggle")
	"t l" '(display-line-numbers-mode :wk "Toggle line numbers")
	"t t" '(visual-line-mode :wk "Toggle truncated lines")
	"t v" '(vterm-toggle :wk "Toggle VTerm")
    )

    (xecarlox/leader-keys
	"f" '(:ignore t :wk "Font")
	"f +" '(text-scale-increase :wk "text scale increase")
	"f -" '(text-scale-decrease :wk "text scale decrease"))

    (xecarlox/leader-keys
	"w"   '(:ignore t :wk "Window")
	"w c" '(evil-window-delete :wk "Close window")
	"w n" '(evil-window-new :wk "New window")
	"w H" '(evil-window-split :wk "Horizontal window split")
	"w V" '(evil-window-vsplit :wk "Vertical window split")

	"w h" '(evil-window-left :wk "Move to window left")
	"w l" '(evil-window-right :wk "Move to window right")
	"w k" '(evil-window-up :wk "Move to window up")
	"w j" '(evil-window-down :wk "Move to window down")
	"w w" '(evil-window-next :wk "Move to next window"))

)


(use-package sudo-edit
  :config
  (xecarlox/leader-keys
    "s" '(:ignore t :wk "Sudo")
    "s f" '(sudo-edit-find-file :wk "Sudo find file")
    "s e" '(sudo-edit-find-file :wk "Sudo edit file")
    )
)



;; which-key package
(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq
          which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit t
	  which-key-separator " → " ))


;; ;; rainbow package
;; (use-package rainbow-mode
  ;; :hook
  ;; ((org-mode prog-mode) . rainbow-mode))


;; Icons packages
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))


(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))


;; Ivy package
(use-package counsel
  :after ivy
  :config (counsel-mode))



(use-package ivy
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d)")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))


(use-package all-the-icons-ivy-rich
  :ensure t
  :init
  (all-the-icons-ivy-rich-mode 1))



(use-package ivy-rich
  :init
  (ivy-rich-mode 1)
  :after counsel
  :config
  (setq ivy-format-function #'ivy-format-function-line))




;; terminals
(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
    (eshell-syntax-highlighting-global-mode +1))


(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "ssh" "zsh"))


(use-package vterm
    :config
    (setq shell-file-name "/bin/sh"
	vterm-max-scrollback 5000))


(use-package vterm-toggle
  :after vterm
  :config
    (setq vterm-toggle-fullscreen-p nil)
    (setq vterm-toggle-scope 'project)
    (add-to-list 'display-buffer-alist
		'((lambda (buffer-or-name _)
			(let ((buffer (get-buffer buffer-or-name)))
			(with-current-buffer buffer
			    (or (equal major-mode 'vterm-mode)
				(string-prefix-p vterm-buffer-name (buffer-name buffer))))))
		    (display-buffer-reuse-window display-buffer-at-bottom)
		    ;;(disay-buffer-reuse-window display-buffer-in-direction)
		    ;;display-buffer-in-direction/direction/dedicated is added in emacs27
		    ;;(direction . bottom)
		    ;;(dedicated . t) ;dedicated is supported in emacs27
		    (reusable-frames . visible)
		    (window-height . 0.3))))




(use-package org
    :straight (:type built-in)
    :init 
	(setq org-directory "~/org")
	(setq org-agenda-files (list org-directory))
    :custom
	(org-startup-indented t)
	(org-startup-folded 'content)
	(org-agenda-start-on-weekday nil)
	(setq org-highest-priority ?A)
	(setq org-lowest-priority ?C)
	(setq org-highest-priority ?A)
)

(use-package evil-org
  :after org
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-mode))
  :config
    (evil-org-mode)
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))

(use-package rainbow-mode)

(use-package rainbow-delimiters
  :init
    (rainbow-delimiters-mode))



(setq org-todo-keywords 
    '((sequence
	"TODO(t)" "CONTRACT(c)" "ACTIVITY(a)" "PROJECT(p)" "LEARNING(l)" "DELIVERABLE(d)" "MEETING(m)" "WISH(w)" 
	"|"
	"HOLD(h)" "SCRAPPED(s)" "FINISHED(f)"))
    org-todo-keyword-faces (quote (
	("TODO(t)" :foreground "orange" :weight bold)
	("CONTRACT(c)" :foreground "red" :weight bold)
	("ACTIVITY(a)" :foreground "yellow" :weight bold)
	("PROJECT(p)" :foreground "green" :weight bold)
	("LEARNING(l)" :foreground "green" :weight bold)
	("DELIVERABLE(d)" :foreground "red" :weight bold)
	("MEETING(m)" :foreground "orange" :weight bold)
	("WISH(w)" :foreground "purple" :weight bold)
	("HOLD(h)" :foreground "grey" :weight bold)
	("SCRAPPED(s)" :foreground "grey" :weight bold)
	("FINISHED(f)" :foreground "grey" :weight bold))))


(setq org-agenda-custom-commands
      `(("A" "Daily agenda and top priority tasks"
         ((tags-todo "*"
                     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                      (org-agenda-skip-function
                       `(org-agenda-skip-entry-if
                         'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                      (org-agenda-block-separator nil)
                      (org-agenda-overriding-header "Important tasks without a date\n")))
          (agenda "" ((org-agenda-span 1)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-scheduled-past-days 0)
                      ;; We don't need the `org-agenda-date-today'
                      ;; highlight because that only has a practical
                      ;; utility in multi-day views.
                      (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header "\nToday's agenda\n")))
          (agenda "" ((org-agenda-start-on-weekday nil)
                      (org-agenda-start-day "+1d")
                      (org-agenda-span 3)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nNext three days\n")))
          (agenda "" ((org-agenda-start-on-weekday nil)
                      ;; We don't want to replicate the previous section's
                      ;; three days, so we start counting from the day after.
                      (org-agenda-start-day "+4d")
                      (org-agenda-span 14)
                      (org-agenda-show-all-dates nil)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n")))))
        ("P" "Plain text daily agenda and top priorities"
         ((tags-todo "*"
                     ((org-agenda-skip-function '(org-agenda-skip-if nil '(timestamp)))
                      (org-agenda-skip-function
                       `(org-agenda-skip-entry-if
                         'notregexp ,(format "\\[#%s\\]" (char-to-string org-priority-highest))))
                      (org-agenda-block-separator nil)
                      (org-agenda-overriding-header "Important tasks without a date\n")))
          (agenda "" ((org-agenda-span 1)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-scheduled-past-days 0)
                      ;; We don't need the `org-agenda-date-today'
                      ;; highlight because that only has a practical
                      ;; utility in multi-day views.
                      (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                      (org-agenda-format-date "%A %-e %B %Y")
                      (org-agenda-overriding-header "\nToday's agenda\n")))
          (agenda "" ((org-agenda-start-on-weekday nil)
                      (org-agenda-start-day "+1d")
                      (org-agenda-span 3)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nNext three days\n")))
          (agenda "" ((org-agenda-start-on-weekday nil)
                      ;; We don't want to replicate the previous section's
                      ;; three days, so we start counting from the day after.
                      (org-agenda-start-day "+4d")
                      (org-agenda-span 14)
                      (org-agenda-show-all-dates nil)
                      (org-deadline-warning-days 0)
                      (org-agenda-block-separator nil)
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                      (org-agenda-overriding-header "\nUpcoming deadlines (+14d)\n"))))
         ((org-agenda-with-colors nil)
          (org-agenda-prefix-format "%t %s")
          (org-agenda-fontify-priorities nil)
          (org-agenda-remove-tags t))
         ("agenda.txt"))
	("v" "A new agenda view"
	    ((tags "+PRIORITY=\"A\""
	    ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'finished))
	    (agenda "")
	    (alltodo "")))))
	)
)



(use-package elfeed)


(setq elfeed-feeds 
      '(("https://yewtu.be/feed/channel/UChNN7VBxPTiNrqjUaQd9bxA" lifestyle)
      ("https://yewtu.be/feed/channel/UCPsCJ1j0G45FnRGqJhCHLiA" finance economy bitcoin)
      ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
