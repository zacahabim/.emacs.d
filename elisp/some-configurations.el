;;; Faster move around
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <up>") 'windmove-up)

(global-set-key (kbd "M-n") '(lambda () (interactive) (next-line  5)))
(global-set-key (kbd "M-p") '(lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "M-<down>") '(lambda () (interactive) (next-line  5)))
(global-set-key (kbd "M-<up>") '(lambda () (interactive) (previous-line 5)))

;; Rebinding the transpose keybindings because Ctrl-t is tmux prefix
(global-set-key (kbd "C-ö") #'transpose-chars)

;;; Confirm before exit
(setq confirm-kill-emacs 'yes-or-no-p)

;;; no backup files
(setq make-backup-files nil)

;;; no autosave
(setq auto-save-default nil)

;;; display fill column
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

;;; whitespace-mode
;; (add-hook 'prog-mode-hook #'whitespace-mode)

;; disable indent
(setq-default indent-tabs-mode nil)

(provide 'some-configurations)
