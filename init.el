;; -------------------------------------------------------------------
;; MELPA initialization
;; -------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; -------------------------------------------------------------------

(add-to-list 'exec-path (expand-file-name "~/.local/bin"))

(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'terminal-key-mappings)
(require 'some-configurations)
(require 'check-my-system-type)
(require 'delete-no-kill-ring)
(require 'pyvenv)
(require 'dockerfile-mode)
(require 'display-buffer-configurations)
(require 'global-mark-navigation)

(require 'sensible-defaults)
(sensible-defaults/increase-gc-threshold)
(sensible-defaults/show-matching-parens)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/treat-camelcase-as-separate-words)
(sensible-defaults/delete-trailing-whitespace)

;; enable mouse usage in terminal
(xterm-mouse-mode)

;; package-install clipetty
(use-package clipetty
  :ensure t
  :config
  (global-clipetty-mode)
  )

(use-package kkp
  :ensure t
  :config
  ;; (setq kkp-alt-modifier 'alt) ;; use this if you want to map the Alt keyboard modifier to Alt in Emacs (and not to Meta)
  (global-kkp-mode +1))

;; theme
;; package-install nord-theme
(use-package nord-theme
  :ensure t
  :config
  (load-theme 'nord t)
  )

;;; undo-tree
;; package-install undo-tree
(use-package undo-tree
  :ensure t
  :init
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :config
  (global-undo-tree-mode)
  )

;; ivy mode
;; package-install ivy
;; package-install counsel
(use-package counsel
  :ensure t
  )
(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode)
  :bind
  (
   ("C-c C-r" . ivy-resume)
   ("<f6>" . ivy-resume)
   ("C-c f f" . counsel-file-jump)
   ("C-c g f" . counsel-git)
   ("C-c g g" . vc-git-grep)
  )
)

;; eglot
(add-hook 'prog-mode-hook 'eglot-ensure)
;; configure python-mode to use pyright language
(require' eglot)
(add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio")))
;; configure tramp to use the remote host path
(with-eval-after-load 'tramp
(add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; fix auto-import
(defun my-eglot-organize-imports () (interactive)
       (eglot-code-actions nil nil "source.organizeImports" t))

(add-hook 'before-save-hook 'my-eglot-organize-imports nil t)
;; (add-hook 'before-save-hook 'eglot-format-buffer)

;; Add extensions
;; pacakge-install corfu
;; pacakge-install cape
(use-package corfu
  :ensure t
  ;; Optional customizations
  :custom
  (corfu-cycle t)                 ; Allows cycling through candidates
  (corfu-auto t)                  ; Enable auto completion
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; insert previewed candidate
  (corfu-preselect 'prompt)
  (corfu-on-exact-match nil)      ; Don't auto expand tempel snippets
  ;; Optionally use TAB for cycling, default is `corfu-complete'.
  :init
  ;; (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)) ; Popup completion info

(use-package cape
  :ensure t
  :defer 10
  ;; :bind
  ;; ;; Add `completion-at-point-functions', used by `completion-at-point'.
  ;; (defun my/add-shell-completion ()
  ;;   (interactive)
  ;;   (add-to-list 'completion-at-point-functions 'cape-history)
  ;;   (add-to-list 'completion-at-point-functions 'pcomplete-completions-at-point))
  ;; (add-hook 'shell-mode-hook #'my/add-shell-completion nil t)
  :config
  ;; Make capfs composable
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'comint-completion-at-point :around #'cape-wrap-nonexclusive)

  ;; Silence then pcomplete capf, no errors or messages!
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)

  ;; Ensure that pcomplete does not write to the buffer
  ;; and behaves as a pure `completion-at-point-function'.
  (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-noninterruptible)
)

;; package-install company
(use-package company
  :ensure t
  :config
  (global-company-mode)
  )

;; install envrc
;; package-install envrc
(use-package envrc
  :ensure t
  :config
  (envrc-global-mode)
  )

;; which-key
;; package-install which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  )

;; version control

;; diff-hl
(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode))

;; magit
;; package-install magit
(use-package magit
  :ensure t
  :defer t
  :init
  (setq magit-blame-echo-style 'headings)
  :bind
  (
   ("C-c g b" . magit-blame)
   ("C-c g s" . magit)
   )
  :hook
  ((magit-pre-refresh  . diff-hl-magit-pre-refresh)
   (magit-post-refresh . diff-hl-magit-post-refresh))
  )

;; ripgrep
;; package-install rg
(use-package rg
  :ensure t
  :bind
  ("C-c r r" . rg)
  )

;; markdown-mode
;; disable this to navigate with M-p and M-p
(add-hook 'markdown-mode-hook
          (lambda()
            (local-unset-key (kbd "M-n"))
            (local-unset-key (kbd "M-p"))
            ))

;;; Configurations saved the GUI
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("98b4ef49c451350c28a8c20c35c4d2def5d0b8e5abbc962da498c423598a1cdd" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" default))
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(term-keys smooth-scrolling clipetty ripgrep nord-theme company rg pyenv-mode auto-virtualenvwrapper projectile auto-virtualenv cape corfu envrc flymake magit which-key lsp-ivy lsp-ui lsp-mode undo-tree counsel ivy yaml-mode groovy-mode ##)))

(cond ((my-system-type-is-darwin)
(custom-set-faces
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "JB" :slant normal :weight regular :height 150 :width normal)))))
) (t
    (custom-set-faces
      '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "JB" :slant normal :weight regular :height 120 :width normal)))))
))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "JB" :slant normal :weight regular :height 150 :width normal)))))
