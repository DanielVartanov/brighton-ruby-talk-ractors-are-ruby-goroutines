(require 'demo-it)

(setq org-tree-slide-header nil)





(setq demo-it--open-windows-size 100)
(setq demo-it--text-scale 5)

;; (demo-it-create :advanced-mode :insert-faster :use-shell
;;                 brightonruby/setup
;;                 brightonruby/setup-shell
;;                 (demo-it-presentation "presentation.org")
                ;; Run compilers in "normal" demo-it shell! vterm is
                ;; needed only for htop!
                ;; (demo-it-run-in-shell "htop --filter=system-threads", "htop", :instant)
;;                 )


(defun brightonruby/setup()
  (centered-window-mode -1)
  (show-paren-mode -1)
  (brightonruby/setup-shell)
  )

(defun brightonruby/setup-shell()
  (demo-it-start-shell)
  (demo-it-run-in-shell "/bin/bash --login" nil :instant)
  (sit-for 3.5)
  (demo-it-run-in-shell "rvm 3.3.2" nil :instant)
  (demo-it-run-in-shell "PS1='$ '" nil :instant)
  (demo-it-run-in-shell "ruby --version" nil :instant)
  (demo-it-hide-mode-line)
  (comint-clear-buffer)
  (sit-for 0.5)
  (comint-clear-buffer)
  )

(defun brightonruby/show-source-code-file (source-code-file &optional scale)
  (unless scale (setq scale 5))

  (centered-window-mode +1)
  (find-file source-code-file)
  (demo-it-hide-mode-line)
  (demo-it-highlight-dwim :line 1 2)
  (fancy-widen)
  (text-scale-set scale)
  (goto-char (point-max))
  (delete-other-windows)
  (message "")
  )

(defun brightonruby/show-source-code-file-and-narrow (source-code-file line-start line-end)
  (brightonruby/show-source-code-file source-code-file)
  (demo-it-highlight-dwim :line line-start line-end)
)

(defun brightonruby/teardown()
  (centered-window-mode -1)
  )

(defun brightonruby/reset-narrow-and-open-shell()
  (fancy-widen)
  (demo-it-run-in-shell "")
  (comint-clear-buffer)
  )

(defun brightonruby/back-to-presentation-slides()
  (centered-window-mode -1)
  (demo-it-presentation-return)
  )


;; (demo-it-create :advanced-mode :insert-faster :use-shell
;;                 (demo-it-presentation "presentation.org") ; Ractors are Ruby's goroutines

;;                 demo-it-presentation-advance



;;                 brightonruby/teardown
;; )

(demo-it-create :advanced-mode :insert-faster :use-shell
                brightonruby/setup

                (demo-it-presentation "presentation.org") ; Ractors are Ruby's goroutines
                (demo-it-show-image "./ruby-3.3.0-release.png")
                (demo-it-show-image "./ruby-3.3.0-release-m-n-ractors.png")

                demo-it-presentation-return ; System threads, they are smart

                (demo-it-load-fancy-file "ractors-system-threads-demo.rs" :line 38 41 :left 2)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "rustc ractors-system-threads-demo.rs")
                (demo-it-run-in-shell "./ractors-system-threads-demo")

                demo-it-presentation-return ; goroutines - they are genius

                (demo-it-load-fancy-file "ractors-goroutines-demo.go" :line 30 37 :left 3)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "go build ractors-goroutines-demo.go")
                (demo-it-run-in-shell "./ractors-goroutines-demo")

                demo-it-presentation-return ; Ruby before 3.0. It's a bit ridiculous...

                (demo-it-load-fancy-file "ractors-ruby-threads-scheduling.rb" :line 28 34 :left)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "ruby ./ractors-ruby-threads-scheduling.rb")

                demo-it-presentation-return ; Introducing GVL!

                (brightonruby/show-source-code-file "gvl-adding-10_000_000-to-bank-account.rb")
                (brightonruby/show-source-code-file "gvl-adding-to-bank-account-10-times.rb")
                (brightonruby/show-source-code-file "gvl-adding-to-bank-account-10-threads.rb")
                (brightonruby/show-source-code-file-and-narrow "gvl-simplest-race-condition-demo.rb" 18 21)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "rvm jruby && ruby --version")
                (demo-it-run-in-shell "ruby gvl-simplest-race-condition-demo.rb")
                brightonruby/back-to-presentation-slides

                demo-it-presentation-advance

                (demo-it-load-fancy-file "many-ractors.rb" :line 23 31 :left)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "rvm 3.0")
                (demo-it-run-in-shell "ruby ./many-ractors.rb")

                demo-it-presentation-return

                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "rvm 3.3.2")
                (demo-it-run-in-shell "ruby ./many-ractors.rb")

                demo-it-presentation-return

                brightonruby/teardown
                )

(demo-it-start)
