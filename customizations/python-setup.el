(setq python-shell-interpreter "/usr/bin/python3.8")

(setq python-shell-interpreter "python3"
      python-shell-interpreter-args "--simple-prompt --pprint")

(setq elpy-rpc-python-command "python3")

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    py-autopep8
    blacken
    ein
    material-theme))

;; Use IPython for REPL
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)
(add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter")


(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


