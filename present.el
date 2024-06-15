(require 'demo-it)

(setq org-tree-slide-header nil)

(demo-it-create :advanced-mode :insert-medium
                (demo-it-presentation "presentation.org")
                demo-it-presentation-advance
                )

(demo-it-start)
