;;======================================================================
;; EL-GET Section

;;----------------------------------------------------------------------
;; 80 ruler
(require 'fill-column-indicator)
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode 1)

;;----------------------------------------------------------------------
;; smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;;----------------------------------------------------------------------
;; json-mode
(setq auto-mode-alist
      (cons '("\.json" . json-mode) auto-mode-alist))

;;----------------------------------------------------------------------
;; rainbow-delimiter-mode
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;----------------------------------------------------------------------
;; yasnippet
(when window-system
  (require 'yasnippet)
  (yas-reload-all)
  (add-hook 'prog-mode-hook 'yas-minor-mode-on)
  (add-hook 'org-mode-hook 'yas-minor-mode-on))

;; indentation with heading and drawers
;; https://github.com/capitaomorte/yasnippet/issues/362
;; NOTE: commented because I haven't encountered yet
;; (setq yas-indent-line 'fixed)

;;----------------------------------------------------------------------
;; auto-complete
;; Note: for ya-snippet to work put it after it

;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-hook 'org-mode-hook 'auto-complete-mode)
;; (ac-linum-workaround)
;; (ac-flyspell-workaround)
;; (global-auto-complete-mode t)

;;----------------------------------------------------------------------
;; play well with org-mode | yasnippet | auto-complete
;; http://orgmode.org/manual/Conflicts.html
;; (defun yas-org-very-safe-expand ()
;;   (let ((yas/fallback-behavior 'return-nil)) (yas-expand)))

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (make-variable-buffer-local 'yas-trigger-key)
;;             (setq yas-trigger-key [tab])
;;             (add-to-list 'org-tab-first-hook 'yas-org-very-safe-expand)
;;             (define-key yas/keymap [tab] 'yas-next-field)))

;;----------------------------------------------------------------------
;; android mode
;; http://blog.refu.co/?p=1242
;; (add-to-list 'load-path "~/opt/android-mode")
;; (require 'android-mode)

;;----------------------------------------------------------------------
;; Emacs Speaks Statistics
;; (defun ess-loader()
;;   (require 'ess-site)
;;   (r-mode t))
;; (when window-system
;;   (setq auto-mode-alist (append '(("\.r$" . ess-loader)) auto-mode-alist)))

;;----------------------------------------------------------------------
;; AUCTeX
;; (when window-system
;;   (load "auctex.el" t)
;;   (setq TeX-auto-save t)
;;   (setq TeX-parse-self t)
;;   (setq-default TeX-master nil)
;;   ;; ;; (load "preview-latex.el" nil t t)
;;   )

;; ;; (add-hook 'LaTeX-mode-hook 'watch-words)
;; (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

;;----------------------------------------------------------------------
;; AUCTeX autocomplete
;; (when window-system
;;   (require 'auto-complete-auctex))

;;----------------------------------------------------------------------
;; markdown mode
(setq auto-mode-alist
      (cons '("\.md" . markdown-mode) auto-mode-alist))
