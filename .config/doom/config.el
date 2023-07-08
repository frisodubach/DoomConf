;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "phonon"
      user-mail-address "mail@phonon.cc")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16)) ;Overpass okay, but want better font.
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/emacs/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;Org configuration
(after! org
  (setq org-hide-emphasis-markers t)
  (setq org-link-descriptive t)
  (setq org-pretty-entities t)
  (setq org-hidden-keywords t))

;;Set org-mode to mixed-pitch to enable Sans-font
(add-hook! 'org-mode-hook #'mixed-pitch-mode)
;;(add-hook! 'org-mode-hook #'solaire-mode) ;;Might not be required

;;Required for setting font-size of mixed-pitch
(after! mixed-pitch
  (setq mixed-pitch-set-height t)
  (setq mixed-pitch-variable-pitch-cursor nil))
;;Would be good to set font-size inside org src-blocks.

;;Org-appear
(add-hook 'org-mode-hook 'org-appear-mode)
(after! org-appear
  (setq org-appear-autolinks t)
  (setq org-appear-autosubmarkers t)
  (setq org-appear-autoentities t)
  (setq org-appear-autokeywords t)
  (setq org-appear-inside-latex t)
  (setq org-appear-trigger 'always))

(setq company-global-modes '(not org-mode)) ;;Disables text completion in org-mode.

;; Org custom pririoties. -- NEED TO INVESTIGATE FURTHER.
(after! org-fancy-priorities
  (setq
   org-fancy-priorities-list '("[!!]" "[!]" "[~]" "[_]")
   org-priority-faces
   '((?A :foreground "#cc241d" :weight bold)
     (?B :foreground "#d79921" :weight bold)
     (?C :foreground "#98971a" :weight bold)
     (?D :foreground "#a89984" :weight bold))
   ))

;;(setq org-fancy-priorities-list '((?A . "❗")
;;                                  (?B . "⬆")
;;                                  (?C . "⬇")
;;                                  (?D . "☕")
;;                                  (?1 . "⚡")
;;                                  (?2 . "⮬")
;;                                  (?3 . "⮮")
;;                                  (?4 . "☕")
;;                                  (?I . "Important")))
;; Super-star Org-headings configuration.
(with-eval-after-load 'org-superstar
  (set-face-attribute 'org-superstar-item nil :height 1.2)
  (set-face-attribute 'org-superstar-header-bullet nil :height 1.2)
  (set-face-attribute 'org-superstar-leading nil :height 1.3))
(with-eval-after-load 'org-superstar
  ;; hide #+TITLE:
  (setq org-hidden-keywords '(title))
  ;; Heading size configuration
  (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default :foreground "#928374" :height 1.0)
  ;; Low levels are unimportant => no scaling
  (set-face-attribute 'org-level-7 nil :inherit 'org-level-8 :foreground "#a89984" :height 1.0)
  (set-face-attribute 'org-level-6 nil :inherit 'org-level-8 :foreground "#d3869b" :height 1.0)
  (set-face-attribute 'org-level-5 nil :inherit 'org-level-8 :foreground "#83a598" :height 1.1)
  (set-face-attribute 'org-level-4 nil :inherit 'org-level-8 :foreground "#8ec07c" :height 1.1)
  ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :foreground "#b8bb26" :height 1.2) ;\large
  (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :foreground "#fabd2f" :height 1.44) ;\Large
  (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :foreground "#fe8019" :height 1.728) ;\LARGE
  (set-face-attribute 'org-document-title nil
                    :height 2.074
                    :foreground "bdae93"
                    :inherit 'org-level-8)
  (setq org-superstar-headline-bullets-list
      '("◉" "◈" "❖" "✿" "❋" "✸" "✦" "➤"))
;;  (setq org-superstar-special-todo-items t)
;;  (setq org-superstar-todo-bullet-alist
;;        '("" ""))
  )

;;Attached stored w/ Org-files
(setq org-attach-id-dir "attachments/")

;; Browser Configuration
;; (setq browse-url-browser-function 'browse-url-generic
;;      browse-url-generic-program "librewolf") ;; Set default generic browser to be librewolf
(setq browse-url-generic-program "librewolf")
(setq browse-url-browser-function 'eww-browse-url) ;; Set default browser to be eww

;; EWW minimal rendering by default
(setq-default shr-inhibit-images t)   ; toggle with `I`
(setq-default shr-use-fonts t)      ; toggle with `F`

;; Elfeed configuration
;;(require 'elfeed-org)
;;(elfeed-org)
(after! elfeed
  (setq elfeed-search-filter "@1-month-ago +unread -us -semi")) ;; standard filter applied when opening
(setq rmh-elfeed-org-files (list "~/Documents/emacs/elfeed.org")) ;; Feed-list configuration path

(add-hook! 'elfeed-search-mode-hook #'elfeed-update) ;; auto update when opening elfeed
(add-hook 'elfeed-show-mode-hook 'variable-pitch-mode);; enable variable pitch mode in reader-buffer

(setq elfeed-goodies/entry-pane-size 0.5) ;; Set size of reader-buffer

;; Keybindings to open article in external browse-url-generic (librewolf) browser
(evil-define-key 'normal elfeed-show-mode-map
  (kbd "g e") '(lambda () (interactive) (elfeed-show-visit t))) ;; Create lambda function to handle argument, make interactive to have command
