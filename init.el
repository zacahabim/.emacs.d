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

;; theme
;; package-install nord-theme
(load-theme 'nord t)

;; undo-tree
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
(global-set-key (kbd "C-c f") 'counsel-file-jump)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c r") 'counsel-rg)

;; lsp-mode
;; package-install lsp-mode
;; package-install lsp-ui
;; package-install lsp-ivy
(setq lsp-keymap-prefix "C-c l")
(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp-deferred)
(lsp-ui-mode)
(lsp-ivy-workspace-symbol)

;; which-key
;; package-install which-key
(which-key-mode)

;; company mode
;; package-install company
(add-hook 'after-init-hook 'global-company-mode)

;; load undo tree

(add-to-list 'load-path "~/.emacs.d/elisp")
(require 'some-configurations)
(require 'check-my-system-type)
(require 'delete-no-kill-ring)

(require 'sensible-defaults)
(sensible-defaults/increase-gc-threshold)
(sensible-defaults/show-matching-parens)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/delete-trailing-whitespace)

;;; Configurations saved the GUI
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(which-key lsp-ivy lsp-ui lsp-mode undo-tree company counsel ivy nord-theme yaml-mode groovy-mode ##)))

(cond ((my-system-type-is-darwin)
(custom-set-faces
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "nil" :slant normal :weight regular :height 150 :width normal)))))
), (t
    (custom-set-faces
      '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "nil" :slant normal :weight regular :height 110 :width normal)))))
))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "nil" :slant normal :weight regular :height 150 :width normal)))))
