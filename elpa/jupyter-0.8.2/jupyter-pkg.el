(define-package "jupyter" "0.8.2" "Jupyter"
  '((emacs "26")
    (zmq "0.10.3")
    (cl-lib "0.5")
    (simple-httpd "1.5.0")
    (websocket "1.9"))
  :commit "403c70c83cb3754c83da0932b0efaf5e72bdca9a" :authors
  '(("Nathaniel Nicandro" . "nathanielnicandro@gmail.com"))
  :maintainer
  '("Nathaniel Nicandro" . "nathanielnicandro@gmail.com")
  :url "https://github.com/dzop/emacs-jupyter")
;; Local Variables:
;; no-byte-compile: t
;; End:
