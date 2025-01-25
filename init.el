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

(require 'sensible-defaults)
(sensible-defaults/increase-gc-threshold)
(sensible-defaults/show-matching-parens)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/delete-trailing-whitespace)
(sensible-defaults/treat-camelcase-as-separate-words)

;; enable mouse usage in terminal
(xterm-mouse-mode)

;; package-install clipetty
(global-clipetty-mode)

;; theme
;; package-install nord-theme
(load-theme 'nord t)

;;; undo-tree
;; package-install undo-tree
(global-undo-tree-mode)
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

;; ivy mode
;; package-install ivy
;; package-install counsel
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)

;; fuzzy search files
(global-set-key (kbd "C-c f f") 'counsel-file-jump)
(global-set-key (kbd "C-c g f") 'counsel-git)
(global-set-key (kbd "C-c g g") 'vc-git-grep)
(global-set-key (kbd "C-c r r") 'rg)

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
(add-hook 'before-save-hook 'eglot-format-buffer)

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
(global-company-mode)

;; install envrc
;; package-install envrc
(envrc-global-mode)

;; which-key
;; package-install which-key
(which-key-mode)

;; magit
;; package-install magit
(setq magit-blame-echo-style 'headings)
(global-set-key (kbd "C-c g b") 'magit-blame)
(global-set-key (kbd "C-c g s") 'magit)

;; ripgrep
;; package-install ripgrep
;; package-install rg
(require 'rg)

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
 '(default ((t (:family "GoMono Nerd Font Mono" :foundry "nil" :slant normal :weight regular :height 150 :width normal)))))
) (t
    (custom-set-faces
      '(default ((t (:family "GoMono Nerd Font Mono" :foundry "nil" :slant normal :weight regular :height 120 :width normal)))))
))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "GoMono Nerd Font Mono" :foundry "nil" :slant normal :weight regular :height 120 :width normal)))))
