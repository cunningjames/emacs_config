;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jay Cunningham"
      user-mail-address "james@notbadafterall.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "consolas" :size 16)
      doom-variable-pitch-font (font-spec :family "helvetica" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq initial-frame-alist '((top . 30) (left . 100) (width . 100) (height . 55)))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(use-package! key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define-global "JJ" 'avy-goto-word-1)
  (key-chord-define-global "GG" 'avy-next)
  (key-chord-define-global "PP" 'avy-prev)
  (key-chord-define-global "jl" 'avy-goto-line)
  (key-chord-define-global "jk" 'avy-goto-char)
  (key-chord-define-global "jj" 'switch-to-previous-buffer)
  (key-chord-define-global "uu" 'undo-fu-only-undo)
  (key-chord-define-global "ii" 'undo-fu-only-redo)
  (key-chord-define-global "fj" 'counsel-find-file)
  (key-chord-define-global "dk" '+ivy/switch-workspace-buffer)
  (key-chord-define-global "DK" '+ivy/switch-buffer)
  (key-chord-define-global "S;" 'isearch-forward)
  (key-chord-define-global "R;" 'isearch-backward)
  (key-chord-define-global "qd" 'kill-buffer)
  (key-chord-define-global "dj" 'counsel-M-x)

  (defvar key-chord-tips
    '("Press <JJ> quickly to jump to the beginning of a visible word."
      "Press <GG> quickly to avy-next."
      "Press <PP> quickly to avy-prev."
      "Press <jl> quickly to jump to a visible line."
      "Press <jk> quickly to jump to a visible character."
      "Press <jj> quickly to switch to previous buffer."
      "Press <uu> quickly to undo."
      "Press <ii> quickly to redo."
      "Press <fj> quickly to find a file."
      "Press <dk> quickly to switch workspace buffers."
      "Press <DK> quickly to switch buffers."
      "Press <qd> quickly to kill the current buffer."
      "Press <dj> quickly to meta x.")))

(define-prefix-command 'cruxy)
(global-set-key (kbd "C-x p") 'cruxy)

(use-package! crux
  :bind (("C-x p o" . crux-open-with)
         ("C-x p j" . crux-smart-open-line)
         ("C-x p n" . crux-cleanup-buffer-or-region)
         ("C-x p f" . crux-recentf-find-file)
         ("C-M-z" . crux-indent-defun)
         ("C-x p u" . crux-view-url)
         ("C-x p e" . crux-eval-and-replace)
         ("C-x p w" . crux-swap-windows)
         ("C-x p D" . crux-delete-file-and-buffer)
         ("C-x p r" . crux-rename-buffer-and-file)
         ("C-x p t" . crux-visit-term-buffer)
         ("C-x p k" . crux-kill-other-buffers)
         ("C-x p TAB" . crux-indent-rigidly-and-copy-to-clipboard)
         ("C-x p I" . crux-find-user-init-file)
         ("C-x p S" . crux-find-shell-init-file)
         ("s-r" . crux-recentf-find-file)
         ("s-j" . crux-top-join-line)
         ("C-^" . crux-top-join-line)
         ("s-k" . crux-kill-whole-line)
         ("C-<backspace>" . crux-kill-line-backwards)
         ("s-o" . crux-smart-open-line-above)
         ([remap move-beginning-of-line] . crux-move-beginning-of-line)
         ([(shift return)] . crux-smart-open-line)
         ([(control shift return)] . crux-smart-open-line-above)
         ([remap kill-whole-line] . crux-kill-whole-line)
         ("C-x p s" . crux-ispell-word-then-abbrev)))


(use-package! ace-window
  :bind* ("M-o" . ace-window)
  :init (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))


(use-package! flycheck
  :init
  (add-hook 'flycheck-mode-hook
            (lambda ()
              (setq flycheck-disabled-checkers '(python-pylint))))
  (add-hook 'python-mode-local-vars-hook
            (lambda ()
              (when (flycheck-may-enable-checker 'python-flake8)
                (flycheck-select-checker 'python-flake8))))
  (setq flycheck-flake8rc "setup.cfg"))


(setq tab-always-indent 't)


(defun toggle-window-split ()
  "Toggle window split between horizontal and vertical."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(define-key ctl-x-4-map "t" 'toggle-window-split)


(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


(use-package! undo-fu
  :after-call doom-switch-buffer after-find-file
  :init
  (after! undo-tree
    (global-undo-tree-mode -1))
  :config
  ;; Store more undo history to prevent loss of data
  (setq undo-limit 400000
        undo-strong-limit 3000000
        undo-outer-limit 3000000)

  (define-minor-mode undo-fu-mode
    "Enables `undo-fu' for the current session."
    :keymap (let ((map (make-sparse-keymap)))
              (define-key map [remap undo] #'undo-fu-only-undo)
              (define-key map [remap redo] #'undo-fu-only-redo)
              (define-key map (kbd "C-_")     #'undo-fu-only-undo)
              (define-key map (kbd "M-_")     #'undo-fu-only-redo)
              (define-key map (kbd "C-M-_")   #'undo-fu-only-redo-all)
              (define-key map (kbd "C-x r u") #'undo-fu-session-save)
              (define-key map (kbd "C-x r U") #'undo-fu-session-recover)
              map)
    :init-value nil
    :global t)
  (undo-fu-mode +1))


(use-package! undo-fu-session
  :hook (undo-fu-mode . global-undo-fu-session-mode)
  :preface
  (setq undo-fu-session-directory (concat doom-cache-dir "undo-fu-session/")
        undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))

  ;; HACK We avoid `:config' here because `use-package's `:after' complicates
  ;;      the load order of a package's `:config' block and makes it impossible
  ;;      for the user to override its settings with merely `after!' (or
  ;;      `eval-after-load'). See jwiegley/use-package#829.
  (after! undo-fu-session
    ;; HACK Use the faster zstd to compress undo files instead of gzip
    (when (executable-find "zstd")
      (defadvice! doom--undo-fu-session-use-zstd-a (filename)
        :filter-return #'undo-fu-session--make-file-name
        (if undo-fu-session-compression
            (concat (file-name-sans-extension filename) ".zst")
          filename)))))

(setq doom-themes-treemacs-enable-variable-pitch nil)


(defun lsp-set-cfg ()
    (let ((lsp-cfg `(:pyls (:configurationSources ("flake8")))))
        ;; TODO: check lsp--cur-workspace here to decide per server / project
        (lsp--set-configuration lsp-cfg)))
(add-hook 'lsp-after-initialize-hook 'lsp-set-cfg)


(god-mode)
(global-set-key (kbd "<escape>") #'god-local-mode)
(define-key god-local-mode-map (kbd "z") #'repeat)
(define-key god-local-mode-map (kbd "i") #'god-local-mode)

(global-set-key (kbd "C-x C-1") #'delete-other-windows)
(global-set-key (kbd "C-x C-2") #'split-window-below)
(global-set-key (kbd "C-x C-3") #'split-window-right)
(global-set-key (kbd "C-x C-0") #'delete-window)

(require 'god-mode-isearch)
(define-key isearch-mode-map (kbd "<escape>") #'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "<escape>") #'god-mode-isearch-disable)

(global-unset-key "\C-c f c")

(define-key global-map (kbd "C-c f c") #'+fold/close)

(global-set-key (kbd "C-c f o") #'+fold/open)
(global-set-key (kbd "C-c f n") #'+fold/close)
(global-set-key (kbd "C-c f t") #'+fold/toggle)
