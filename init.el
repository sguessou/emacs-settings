;;;;
;; Packages
;;;;

;; Define package repositories
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;; Load and activate emacs packages. Do this first so that the
;; packages are loaded before you start trying to modify them.
;; This also sets the load path.
(package-initialize)

(setq use-package-always-ensure nil)

(unless (require 'use-package nil t)
  (if (not (yes-or-no-p (concat "Refresh packages, install use-package and"
                                " other packages used by init file? ")))
      (error "you need to install use-package first")
    (package-refresh-contents)
    (package-install 'use-package)
    (require 'use-package)
    (setq use-package-always-ensure t)))

;; Download the ELPA archive description if needed.
;; This informs Emacs about the latest versions of all packages, and
;; makes them available for download.
(when (not package-archive-contents)
  (package-refresh-contents))

;; Define he following variables to remove the compile-log warnings
;; when defining ido-ubiquitous
;; (defvar ido-cur-item nil)
;; (defvar ido-default-item nil)
;; (defvar ido-cur-list nil)
;; (defvar predicate nil)
;; (defvar inherit-input-method nil)

;; The packages you want installed. You can also install these
;; manually with M-x package-install
;; Add in your own as you wish:
(defvar my-packages
  '(;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit

    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode

    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking

    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    cider

    ;; allow ido usage in as many contexts as possible. see
    ;; customizations/navigation.el line 23 for a description
    ;; of ido
    ido-completing-read+

    ;; Enhances M-x to allow easier execution of commands. Provides
    ;; a filterable list of possible commands in the minibuffer
    ;; http://www.emacswiki.org/emacs/Smex
    smex

    ;; project navigation
    projectile

    ;; colorful parenthesis matching
    rainbow-delimiters

    ;; edit html tags like sexps
    tagedit

    ;; git integration
    magit))

;; On OS X, an Emacs instance started from the graphical user
;; interface will have a different environment than a shell in a
;; terminal window, because OS X does not run a shell during the
;; login. Obviously this will lead to unexpected results when
;; calling external utilities like make from Emacs.
;; This library works around this problem by copying important
;; environment variables from the user's shell.
;; https://github.com/purcell/exec-path-from-shell
(if (eq system-type 'darwin)
    (add-to-list 'my-packages 'exec-path-from-shell))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Place downloaded elisp files in ~/.emacs.d/vendor. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;; 
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")


;;;;
;; Customization
;;;;

;; Add a directory to our load path so that when you `load` things
;; below, Emacs knows where to look for the corresponding file.
(add-to-list 'load-path "~/.emacs.d/customizations")

;; Sets up exec-path-from-shell so that Emacs will use the correct
;; environment variables
(load "shell-integration.el")

;; These customizations make it easier for you to navigate files,
;; switch buffers, and choose options from the minibuffer.
(load "navigation.el")

;; These customizations change the way emacs looks and disable/enable
;; some user interface elements
(load "ui.el")

;; These customizations make editing a bit nicer.
(load "editing.el")

;; Hard-to-categorize customizations
(load "misc.el")

;; For editing lisps
(load "elisp-editing.el")

;; Language-specific
(load "setup-clojure.el")
(load "setup-js.el")

;; Golang
(load "go-setup.el")

;; Python3
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(load "python-setup.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "7f1263c969f04a8e58f9441f4ba4d7fb1302243355cb9faecb55aec878a06ee9" "9e54a6ac0051987b4296e9276eecc5dfb67fdcd620191ee553f40a9b6d943e78" default))
 '(global-eldoc-mode nil)
 '(package-selected-packages
   '(jedi dockerfile-mode doom-themes ewal-spacemacs-themes jupyter ein blackboard-theme drag-stuff py-autopep8 python-black kivy-mode autopair company-go go-rename go-guru use-package go-autocomplete go-mode restclient-test helm-projectile ivy helm-core helm-mode-manager ## avy ace-window magit tagedit rainbow-delimiters projectile smex ido-completing-read+ cider clojure-mode-extra-font-locking clojure-mode paredit exec-path-from-shell))
 '(safe-local-variable-values
   '((cider-clojure-cli-global-options . "-A:dev:test:eastwood"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil :height 180)

;;(global-set-key [f-left] 'windmove-left)          ; move to left window
;;(global-set-key [f-right] 'windmove-right)        ; move to right window
;;(global-set-key [f-up] 'windmove-up)              ; move to upper window
;;(global-set-key [-down] 'windmove-down)          ; move to lower window

(require 'multiple-cursors)

(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)


(global-company-mode)

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

(require 'flycheck-clj-kondo)
(global-flycheck-mode)


(global-aggressive-indent-mode 1)


(global-set-key (kbd "<C-return>") 'cider-pprint-eval-last-sexp-to-comment)

(require 'ace-window)


(global-set-key (kbd "M-o") 'ace-window)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

(require 'projectile)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'helm-projectile)
(helm-projectile-on)

(setq projectile-switch-project-action #'projectile-dired)

(setq projectile-completion-system 'ivy)

(setq projectile-project-search-path '("~/omaposti/mobile-backend/backend-service" "~/omaposti/mobile-backend/graphql-apigw" "~/golang-stuff" "~/golang-stuff/oauth-project"))

(setq projectile-switch-project-action #'projectile-find-dir)

(setq projectile-find-dir-includes-top-level t)

(setq projectile-indexing-method 'hybrid)

(require 'restclient)


(setenv "JAVA_HOME"
        "/home/saadg/.sdkman/candidates/java/current")

(setenv "JAVA_CMD"
        "/home/saadg/.sdkman/candidates/java/current/bin/java")


;; Ivy completion
;; https://github.com/abo-abo/swiper
(ivy-mode 1)
(define-key ivy-minibuffer-map (kbd "S-<up>") #'ivy-previous-history-element)
(define-key ivy-minibuffer-map (kbd "S-<down>") #'ivy-next-history-element)

;; Terraform
;; https://github.com/emacsorphanage/terraform-mode
(require 'terraform-mode)
(add-to-list 'auto-mode-alist '("\\.tf\\'" . terraform-mode))
(add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml\\'" . yaml-mode))

(drag-stuff-mode t)
(drag-stuff-global-mode 1)
(drag-stuff-define-keys)

(use-package multiple-cursors
  :ensure t
  :bind (("M-." . mc/mark-next-like-this)
         ("M-," . mc/unmark-next-like-this)
         ("C-S-<mouse-1>" . mc/add-cursor-on-click)))

;;init.el ends here
