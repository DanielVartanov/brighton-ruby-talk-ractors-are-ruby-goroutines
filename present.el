(require 'demo-it)

(setq org-tree-slide-header nil)

(defun brightonruby/setup()
  (vterm "htop")
  (demo-it-insert "htop --filter=ractors\n")
  )

(defun brightonruby/show-shell (name)
  (switch-to-buffer name)
)

(setq demo-it--open-windows-size 100)
(setq demo-it--text-scale 2)

;; (demo-it-create :advanced-mode :insert-faster :use-shell
;;                 brightonruby/setup
;;                 brightonruby/setup-shell
;;                 (demo-it-presentation "presentation.org")
                ;; Run compilers in "normal" demo-it shell! vterm is
                ;; needed only for htop!
                ;; (demo-it-run-in-shell "htop --filter=system-threads", "htop", :instant)
;;                 )


(defun brightonruby/setup-shell()
  (demo-it-start-shell)
  (demo-it-run-in-shell "/bin/bash --login" nil :instant)
  (sit-for 3.5)
  (demo-it-run-in-shell "rvm 3.3.2" nil :instant)
  (demo-it-run-in-shell "PS1='$ '" nil :instant)
  (demo-it-run-in-shell "ruby --version" nil :instant)
  (demo-it-hide-mode-line)
  (comint-clear-buffer)
  )

(demo-it-create :advanced-mode :insert-faster :use-shell
                (demo-it-load-fancy-file "ractors-system-threads-demo.rs" :line 35 45 :left)
                (demo-it-run-in-shell "rustc ractors-system-threads-demo.rs")
                (demo-it-run-in-shell "./ractors-system-threads-demo")

                demo-it-presentation-return

                (demo-it-load-fancy-file "ractors-goroutines-demo.go" :line 30 37 :left)
                (demo-it-run-in-shell "go build ractors-goroutines-demo.go")
                (demo-it-run-in-shell "./ractors-goroutines-demo")

)

(demo-it-create :advanced-mode :insert-faster :use-shell
                (demo-it-start-shell)
                (demo-it-run-in-shell "/bin/bash --login" nil :instant)
                (demo-it-run-in-shell "rvm 3.3.2" nil :instant)
                (demo-it-run-in-shell "PS1='$ '" nil :instant)
                (demo-it-run-in-shell "ruby --version" nil :instant)
                (demo-it-hide-mode-line)
                (comint-clear-buffer)

                (demo-it-presentation "presentation.org")
                (demo-it-show-image "./ruby-3.3.0-release.png")
                (demo-it-show-image "./ruby-3.3.0-release-m-n-ractors.png")

                demo-it-presentation-return

                (demo-it-load-fancy-file "ractors-system-threads-demo.rs" :line 35 45 :left)
                (demo-it-run-in-shell "rustc ractors-system-threads-demo.rs")
                (demo-it-run-in-shell "./ractors-system-threads-demo")

                demo-it-presentation-return

                (demo-it-load-fancy-file "ractors-goroutines-demo.go" :line 30 37 :left)
                (demo-it-run-in-shell "go build ractors-goroutines-demo.go")
                (demo-it-run-in-shell "./ractors-goroutines-demo")

                demo-it-presentation-return

                (demo-it-load-fancy-file "ractors-ruby-threads-scheduling.rb" :line 28 34 :left)
                (demo-it-run-in-shell "ruby ./ractors-ruby-threads-scheduling.rb")

                demo-it-presentation-return
                demo-it-presentation-advance

                (demo-it-load-fancy-file "many-ractors.rb" :line 23 31 :left)
                (demo-it-run-in-shell "rvm 3.0")
                (demo-it-run-in-shell "ruby ./many-ractors.rb")

                demo-it-presentation-return

                (demo-it-run-in-shell "rvm 3.3")
                (demo-it-run-in-shell "ruby ./many-ractors.rb")

                demo-it-presentation-return

                )

(demo-it-start)
