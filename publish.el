;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Variables
;; Set the Website name
(setq site-title "<div class=\"Haider\"><a href='https://www.haider.gq/'>Haider Mirza</a></div>")

;; Links used in the head of the html file
(setq site-link-href (concat 
;; <link rel="stylesheet" href="file:///home/haider/haider-mirza.github.io/public/base/stylesheet.css"/>
		      "<link rel=\"stylesheet\" href=\"https://www.haider.gq/base/stylesheet.css\"/>"
		      "\n"
		      "<link href=\"https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@600&display=swap\" rel=\"stylesheet\">"
		      "\n"
		      "<link href=\"https://fonts.googleapis.com/css2?family=Roboto\" rel=\"stylesheet\">"
		      "\n"
		      "<link href=\"https://fonts.googleapis.com/css2?family=Lato:wght@900&display=swap\" rel=\"stylesheet\">"
		      ))

;; Set links
(setq site-links
      "<div class='nav'>
      <div class='links'>
	<a href='https://www.haider.gq'>Home</a>
	<a href='https://www.haider.gq/about/about.html'>About</a>
	<a href='https://www.haider.gq/repos/repos.html'>Repos</a>
	<a href='https://www.haider.gq/projects/projects.html'>Projects</a>
	<a href='https://www.haider.gq/school/school.html'>School</a>
      </div>
      </div>")

;; Functions
;; Set the preamble
(defun dw/site-preamble ()
  (concat site-title " " site-links))

;; Set the postamble
(defun dw/site-postamble ()
  (concat "<p>Made with Org mode 9.4.4 using the power of Emacs 27.2</p>"))


;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil) ;; Use our own styles

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
	     :html-head site-link-href
	     :html-preamble  (dw/site-preamble)
	     :html-postamble (dw/site-postamble)
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Dont include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :with-timestamps t
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; We're using Git, we don't need no steenking backups
(setq make-backup-files nil)

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
