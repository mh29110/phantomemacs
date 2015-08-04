
(setq ring-bell-function 'ignore)       ;关闭烦人的出错时的提示声

;;; ### Coding ###
;;; --- 编码设置
(setq default-buffer-file-coding-system 'utf-8-unix)            ;缓存文件编码
(setq default-file-name-coding-system 'utf-8-unix)              ;文件名编码
(setq default-keyboard-coding-system 'utf-8-unix)               ;键盘输入编码
(setq default-process-coding-system '(utf-8-unix . utf-8-unix)) ;进程输出输入编码
(setq default-sendmail-coding-system 'utf-8-unix)               ;发送邮件编码
(setq default-terminal-coding-system 'utf-8-unix)               ;终端编码


;;; ### Indent ###
;;; --- 缩进设置
(setq-default indent-tabs-mode t)       ;默认不用空格替代TAB
(setq default-tab-width 2)              ;设置TAB默认的宽度
(dolist (hook (list                     ;设置用空格替代TAB的模式
               'emacs-lisp-mode-hook
               'lisp-mode-hook
               'lisp-interaction-mode-hook
               'scheme-mode-hook
               'c-mode-hook
               'c++-mode-hook
               'java-mode-hook
               'haskell-mode-hook
               'asm-mode-hook
               'emms-tag-editor-mode-hook
               'sh-mode-hook
               'js2-mode
               ))
  (add-hook hook '(lambda () (setq indent-tabs-mode nil))))

;;; ### Windows ###
;;; --- 用于保存和管理窗口的配置方案
;;(win:startup-with-window)
;;(setq win:configuration-file "~/MyEmacs/Configure-File/Windows/windows-configure") ;窗口布局管理保存文件


;;载入ac-js2-mode  . 不能过早载入,必须在skewer-mode后,否则会导致run-skewer无法连接server
(add-hook 'js2-mode-hook 'ac-js2-mode)
; (add-hook 'js2-mode-hook 'ac-js2-mode)
; (setq ac-js2-evaluate-calls t)
; (setq ac-js2-external-libraries '("full/path/to/a-library.js"))

;; init-emacs-w3m.el 中browse-url-generic-program定制各个系统的浏览器路径
;; 不需要重复定义了.
; (setq browse-url-generic-program "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")



;; org capture templates  call
;;  M-x org-capture  
(setq org-capture-templates
      (quote (("t" "todo" entry (file (concat org-directory "/gtd.org"))
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("n" "note" entry (file (concat org-directory "/gtd.org"))
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree (concat org-directory "/diary.org"))
               "* %?\n%U\n" :clock-in t :clock-resume t)
              )))
(provide 'init-custom-win)