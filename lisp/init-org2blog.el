;;  @see http://blog.nethazard.net/post-to-wordpress-blogs-with-emacs-org-mode/
(require 'org2blog-autoloads)
;;  setup proxy
;; (setq url-proxy-services '(("http" . "127.0.0.1:8580"))) ;; fr*egate
;; (setq url-proxy-services '(("http" . "127.0.0.1:8000"))) ;; gae
;; (setq url-proxy-services '(("http" . "127.0.0.1:8118"))) ;; privoxy
(setq url-proxy-services '(("http" . "theironislands.f.getqujing.net:34577"))) ;; privoxy

;; I would rather manage code syntax by myself
(setq org2blog/wp-sourcecode-langs
      '("actionscript3" "bash" "coldfusion" "cpp" "csharp" "css" "delphi"
        "erlang" "fsharp" "diff" "groovy" "javascript" "java" "javafx" "matlab"
        "objc" "perl" "php" "text" "powershell" "python" "ruby" "scala" "sql"
        "vb" "xml" "sh" "elisp" "lisp" "lua"))

(setq org2blog/wp-use-sourcecode-shortcode t)
;; (setq org2blog/wp-blog-alist
      ;; '(("wordpress"
      ;;    :url "http://phantomjia.wordpress.com/xmlrpc.php"
      ;;    :username "phantomjia"
      ;;    ;; :default-title "hello"
      ;;    ;; :default-categories ("Linux")
      ;;    :tags-as-categories nil
      ;;    )
      ;;   ))
(setq org2blog/wp-blog-alist
      '(("phantomjia"
         :url "http://121.40.186.180/wordpress/xmlrpc.php"
         :username "phantomjia"
         :default-title "Hello World"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
        ("my-blog"
         :url "http://phantomjia.server.com/xmlrpc.php"
         :username "admin")))
(defun my-org2blog-post-subtree ()
  (interactive)

  (require 'xml-rpc-autoloads)
  ;; go to the top node which is a blog item
  ;;(outline-up-heading)

  ;; post and publish
  (org2blog/wp-post-subtree t)
  (let* ((postid (or (org-entry-get (point) "POSTID")
                     (org-entry-get (point) "POST_ID")))
         (url org2blog/wp-server-xmlrpc-url))
    (if (not postid)
        (message "This subtree hasn't been posted, yet.")
      (setq url (substring url 0 -10))
      (setq url (concat url "?p=" postid ))
      (kill-new url)
      (with-temp-buffer
        (insert url)
        (shell-command-on-region (point-min) (point-max)
                                 (cond
                                  ((eq system-type 'cygwin) "putclip")
                                  ((eq system-type 'darwin) "pbcopy")
                                  (t "xsel -ib")
                                  )))
      (message (concat url " => clipboard"))
      )))

(provide 'init-org2blog)
