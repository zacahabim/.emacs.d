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
(load-theme 'solarized-dark t)

(add-to-list 'load-path "~/.emacs.d")
(require 'sensible-defaults)
(require 'some-configurations)

(sensible-defaults/increase-gc-threshold)
(sensible-defaults/show-matching-parens)
(sensible-defaults/bind-home-and-end-keys)
(sensible-defaults/bind-keys-to-change-text-size)



;;; Modify behaviors of delete
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun my-backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (my-delete-word (- arg)))

(defun my-delete-line ()
  "Delete text from current position to end of line char."
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
  (delete-char 1)
)

(defun my-delete-line-backward ()
  "Delete text between the beginning of the line to the cursor position."
  (interactive)
  (let (x1 x2)
    (setq x1 (point))
    (move-beginning-of-line 1)
    (setq x2 (point))
    (delete-region x1 x2)))

; Here's the code to bind them emacs's default shortcut keys:
(global-set-key (kbd "M-d") 'my-delete-word)
(global-set-key (kbd "<M-backspace>") 'my-backward-delete-word)
(global-set-key (kbd "C-k") 'my-delete-line)
(global-set-key (kbd "C-S-k") 'my-delete-line-backward)

;;; lsp-mode
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (python-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;;; Configurations saved the GUI
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(solarized-theme ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrainsMono Nerd Font" :foundry "nil" :slant normal :weight regular :height 140 :width normal)))))
