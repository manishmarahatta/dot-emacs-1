(require 'powerline)
(setq powerline-default-separator 'wave)

;; Make a face for the octicons font (must be installed on your system)
;; https://octicons.github.com/
(make-face 'octicons)
(set-face-attribute 'octicons nil
                    :family "octicons")
(setq octicon-mark-github " ")
(setq octicon-rocket "")

;; mode icon stuff
;; https://github.com/rhoit/mode-icons/
(load-file "~/.emacs.d/00testing/mode-icons/mode-icons.el")
(mode-icons-mode)

;; temporary fix
;; (set-face-background 'which-func "gray40") ; move to customize face

(defun powerline-simpler-vc-mode (s)
  (if s
      (replace-regexp-in-string "Git[:-]" "" s)
    s))

(setq which-func-format
      `(" "
        (:propertize which-func-current local-map
                     (keymap
                      (mode-line keymap
                                 (mouse-3 . end-of-defun)
                                 (mouse-2 . narrow-to-defun)
                                 (mouse-1 . beginning-of-defun)))
                     face which-func
                     mouse-face mode-line-highlight
                     help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end")
        " "))

(defun powerline-rho-theme ()
  "A powerline theme that removes many minor-modes that don't
serve much purpose on the mode-line."
  (interactive)
  (setq-default
   mode-line-format
   '("%e"
     (:eval
      (let* ((active (powerline-selected-window-active))
             (mode-line (if active 'mode-line 'mode-line-inactive))
             (face1 (if active 'powerline-active1 'powerline-inactive1))
             (face2 (if active 'powerline-active2 'powerline-inactive2))
             (separator-left (intern (format "powerline-%s-%s"
                                             (powerline-current-separator)
                                             (car powerline-default-separator-dir))))
             (separator-right (intern (format "powerline-%s-%s"
                                              (powerline-current-separator)
                                              (cdr powerline-default-separator-dir))))
             (lhs (list (powerline-raw "%*" nil 'l)
                        (when powerline-display-mule-info
                          (powerline-raw mode-line-mule-info nil 'l))
                        (powerline-raw " ")
                        (funcall separator-left nil face2)
                        (when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                          (powerline-raw erc-modified-channels-object face1 'l))
                        (powerline-major-mode face2 'l)
                        (powerline-raw " " face2)
                        (funcall separator-right face2 face1)
                        (powerline-process face1)
                        (powerline-minor-modes face1 'l)
                        (powerline-narrow face1 'l)
                        (powerline-raw " " face1)
                        ;;            (powerline-zigzag-left face1 nil)
                        ;;            (powerline-raw " " nil)
                        ))
             (center (list
                      (when (and (boundp 'which-func-mode) which-func-mode)
                        (powerline-arrow-left face1 face2))
                      (when (and (boundp 'which-func-mode) which-func-mode)
                        (powerline-raw which-func-format face2 'l))
                      (when (and (boundp 'which-func-mode) which-func-mode)
                        (powerline-raw " " face2))
                      (when (and (boundp 'which-func-mode) which-func-mode)
                        (powerline-zigzag-right face2 nil))
                      ))
             (rhs (list (powerline-raw global-mode-string nil 'r)
                        (when (vc-backend buffer-file-name)
                          (funcall separator-left nil face2))
                        (when (vc-backend buffer-file-name)
                          (powerline-raw octicon-mark-github face2))
                        (powerline-simpler-vc-mode (powerline-vc face2 'r))
                        (when (vc-backend buffer-file-name)
                          (funcall separator-right face2 nil))
                        (powerline-raw " " nil)
                        (powerline-zigzag-left nil face1)
                        (powerline-raw "%3c," face1 'r)
                        (powerline-raw "%p" face1 'r)
                        (powerline-zigzag-right face1 nil)
                        (powerline-raw "  " nil)
                        )))
        (concat (powerline-render lhs)
                (powerline-render center)
                (powerline-fill nil (powerline-width rhs))
                (powerline-render rhs))
        )))))

(defvar mode-line-cleaner-alist
  `((auto-complete-mode . "")
    ;; (yas-minor-mode . (get-mode-icon "YASnippet"))
    ;; (yas-minor-mode . #("YASnippet" 0 9 (display (image :type xpm :file (mode-icons-get-icon-file "yas.xpm") :ascent center))))
    ;; (yas-minor-mode . #(" YASnippet" 0 9 (display (image :type xpm :file "/home/rho/.emacs.d/00testing/mode-icons/icons/yas.xpm" :ascent center))))
    ;; (auto-dim-other-buffers-mode . #("auto-dim-other-buffers" 0 22 (display (image :type xpm :file "~/.emacs.d/00testing/mode-icons/icons/dim.xpm" :ascent center))))
    (yas-minor-mode . #("YASnippet " 0 9 (display (image :type xpm :file "~/.emacs.d/00testing/mode-icons/icons/yas.xpm" :ascent center))))
    ;; (hs-minor-mode . "aoue")
    (hs-minor-mode . #("hs " 0 2 (display (image :type xpm :file "/home/rho/.emacs.d/00testing/mode-icons//icons/hs.xpm" :ascent center))))
    (outline-minor-mode . " Outline ")
    (auto-dim-other-buffers-mode . "")
    (highline-mode . "")
    (highlight-indentation-mode . "")
    (anzu-mode . "")
    (markdown-mode . "")
    (smooth-scroll-mode . "")
    (undo-tree-mode . ""))
  "Alist for `clean-mode-line'.
When you add a new element to the alist, keep in mind that you
must pass the correct minor/major mode symbol and a string you
want to use in the modeline *in lieu of* the original.")

(defun clean-mode-line ()
  (interactive)
  (loop for cleaner in mode-line-cleaner-alist
        do (let* ((mode (car cleaner))
                  (mode-str (cdr cleaner))
                  (old-mode-str (cdr (assq mode minor-mode-alist))))
             (when old-mode-str
               (setcar old-mode-str mode-str))
             ;; major mode
             (when (eq mode major-mode)
               (setq mode-name mode-str)))))


;; modeline from spacmacs
(add-to-list 'load-path  "~/.emacs.d/00testing/spaceline/")
(require 'spaceline-config)
;; (spaceline-spacemacs-theme)

(powerline-rho-theme)
(add-hook 'after-change-major-mode-hook 'clean-mode-line)