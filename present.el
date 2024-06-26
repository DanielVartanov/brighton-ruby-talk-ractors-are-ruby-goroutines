(require 'demo-it)

(setq org-tree-slide-header nil)
(setq demo-it--open-windows-size 100)
(setq demo-it--text-scale 5)

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

(defun brightonruby/show-source-code-file-and-narrow (source-code-file line-start line-end &optional scale)
  (brightonruby/show-source-code-file source-code-file scale)
  (demo-it-highlight-dwim :line line-start line-end)
)

(defun brightonruby/teardown()
  (centered-window-mode -1)
  )

(defun brightonruby/reset-narrow-and-open-shell()
  (fancy-widen)
  (centered-window-mode -1)
  (demo-it-run-in-shell "")
  (comint-clear-buffer)
  )

(defun brightonruby/back-to-presentation-slides()
  (centered-window-mode -1)
  (demo-it-presentation-return)
  )



(demo-it-create :advanced-mode :insert-faster :use-shell
                brightonruby/setup

                (demo-it-presentation "presentation.org") ; Ractors are Ruby's goroutines
                (demo-it-show-image "./ruby-3.3.0-release.png")
                (demo-it-show-image "./ruby-3.3.0-release-m-n-ractors.png")

                brightonruby/back-to-presentation-slides ; System threads, they are smart

                (brightonruby/show-source-code-file-and-narrow "ractors-system-threads-demo.rs" 38 42 4)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "rustc ractors-system-threads-demo.rs")
                (demo-it-run-in-shell "./ractors-system-threads-demo")

                brightonruby/back-to-presentation-slides ; goroutines - they are genius

                (brightonruby/show-source-code-file-and-narrow "ractors-goroutines-demo.go" 31 38)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "go build ractors-goroutines-demo.go")
                (demo-it-run-in-shell "./ractors-goroutines-demo")

                brightonruby/back-to-presentation-slides ; Ruby before 3.0. It's a bit straightforward...

                (demo-it-load-fancy-file "ractors-ruby-threads-scheduling.rb" :line 28 31 :left)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "ruby ./ractors-ruby-threads-scheduling.rb")

                brightonruby/back-to-presentation-slides ; Introducing GVL

                ;; Compose a simplest race condition
                (brightonruby/show-source-code-file "gvl-adding-10_000_000-to-bank-account.rb")
                (brightonruby/show-source-code-file "gvl-adding-to-bank-account-10-times.rb")
                (brightonruby/show-source-code-file "gvl-adding-to-bank-account-10-threads.rb")
                (brightonruby/show-source-code-file-and-narrow "gvl-simplest-race-condition-demo.rb" 18 21)
                brightonruby/reset-narrow-and-open-shell
                (demo-it-run-in-shell "rvm jruby && ruby --version")
                (demo-it-run-in-shell "ruby gvl-simplest-race-condition-demo.rb")

                ;; The line that caused the race condition
                (brightonruby/show-source-code-file-and-narrow "gvl-simplest-race-condition-demo.rb" 13 13)
                (brightonruby/show-source-code-file "gvl-race-condition-line-expanded.rb")
                (split-window-horizontally)

                ;; GVL seemlingly protects us
                (brightonruby/show-source-code-file "gvl-seemingly-protects.rb")
                (demo-it-run-in-shell "rvm 3.0 && ruby --version")
                (demo-it-run-in-shell "ruby gvl-seemingly-protects.rb")
                (brightonruby/show-source-code-file "gvl-innocent-refactoring.rb" 4)
                (demo-it-run-in-shell "ruby gvl-innocent-refactoring.rb")

                brightonruby/back-to-presentation-slides ; Two questions

                demo-it-presentation-advance ; Parellelism != Concurrency
                demo-it-presentation-advance ; Parellelism != Concurrency, Two threads
                demo-it-presentation-advance ; Parellelism != Concurrency, Neither parallel nor concurrent
                demo-it-presentation-advance ; Parellelism != Concurrency, Parallel and Concurrent
                demo-it-presentation-advance ; Parellelism != Concurrency, Concurrent but not parallel

                demo-it-presentation-advance ; Two questions (1/2)
                demo-it-presentation-advance ; Two questions (2/2)

                demo-it-presentation-advance ; +Global+ Great Virtual machine Lock
                demo-it-presentation-advance ; Ruby 3.0: Ractors were introduced (2020). And they were less than ideal...

                brightonruby/back-to-presentation-slides ; Ruby 3.3: M:M vs M:N (2023)
                (demo-it-show-image "./ruby-3.3-mm-vs-mn.png" :below)

                (brightonruby/show-source-code-file-and-narrow "ruby-3.3-lightweight-ractors-demo.rb" 18 26)
                (demo-it-run-in-shell "rvm 3.3.2 && ruby --version")
                (demo-it-run-in-shell "ruby ruby-3.3-lightweight-ractors-demo.rb")

                brightonruby/back-to-presentation-slides ; How to contact me (and why)
                (demo-it-show-image "./contact.png" :below)

                brightonruby/teardown
                )

(demo-it-start)
