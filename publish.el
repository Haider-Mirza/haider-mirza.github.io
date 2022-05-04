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
;; (setq site-title "<div class=\"Haider\"><a href='https://www.haider.gq/'>Haider Mirza</a></div>")

;; Links used in the head of the html file
(setq site-link-href (concat 
		      ;; <link rel="stylesheet" href="file:///home/haider/haider-mirza.github.io/public/base/stylesheet.css"/>
		      "<link rel=\"icon\" type=\"base/favicon\" href=\"/base/favicon.png\">"
		      "\n"
		      "<link rel=\"stylesheet\" href=\"https://www.haider.gq/base/style.css\"/>"
		      "\n"
		      "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\" />"
		      "\n"
		      "<link href=\"https://fonts.googleapis.com/css2?family=Roboto+Slab:wght@600&display=swap\" rel=\"stylesheet\">"))

;; Functions
;; Set the preamble
(defun dw/site-preamble ()
  (concat "<header>
	  <a href='https://www.haider.gq' class='main_header'>Haider Mirza</a>
	  <nav>
	    <ul class='nav_links'>
	      <li><a href='https://www.haider.gq/about/about'>About</a></li>
	      <li><a href='https://www.haider.gq/projects/projects'>Projects</a></li>
	      <li><a href='https://www.haider.gq/notes'>Notes</a></li>
	      <li><a href='https://www.haider.gq/search/search'>Search</a></li>
	    </ul>
	  </nav>
	</header>"))

;; Set the postamble
(defun dw/site-postamble ()
  (concat "<footer>
	  <div class='footer-content'>
	    <h3>Haider Mirza</h3>
	    <p>Website created by Haider Mirza</p>
	    <ul class='socials'>
	      <li><a href='https://www.github.com/Haider-Mirza'><i class='fa fa-github'></i></a></li>
	      <li><a href='mailto:x7and7@gmail.com'><i class='fa fa-envelope'></i></a></li>
	    </ul>
	  </div>
	  <div class='footer-bottom'>
	    <p>Created by Haider Mirza with orgroam in emacs</p>
	  </div>
	</footer>"))


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
