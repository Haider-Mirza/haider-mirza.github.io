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
(package-install 'find-lisp)
(package-install 'org-roam)
(package-install 's)

(require 's)
(require 'ox-publish)
(require 'find-lisp)
(require 'org-roam)

;; <link rel="stylesheet" href="file:///home/haider/haider-mirza.github.io/public/base/style.css"/>

;; Links used in the head of the html file
(setq site-link-href (concat 
		      "<link rel='stylesheet' href='https://www.haider.gq/base/style.css'/> \n"
		      "<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' /> \n"
		      "<link rel='preconnect' href='https://fonts.googleapis.com'> \n"
		      "<link rel='preconnect' href='https://fonts.gstatic.com' crossorigin> \n"
		      "<link href='https://fonts.googleapis.com/css2?family=Poppins:ital@1&family=Roboto&display=swap' rel='stylesheet'>\n"
		      "<link href='https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap' rel='stylesheet'>\n"
		      "<script src='https://kit.fontawesome.com/e139214a06.js' crossorigin='anonymous'></script> \n"
		      "<meta name='keywords' content='development, coding, programming, linux, emacs, guix'>\n"
		      "<link rel='icon' type='image/x-icon' href='/base/favicon.png'>\n"
		      "<meta name='description' content=\"Haider Mirza's website\">\n"))

;; Functions
;; Set the preamble
(defun dw/site-preamble ()
  (concat "<div class='grid-container'>
      <div class='grid-item header'>

	<a href='https://www.haider.gq' class='Header_Title'>
	  <span class='Header_Haider-Mirza'>Haider Mirza</span>
	</a>
	<ul class='Header_links'>
	  <li><a href='https://www.haider.gq/blogs/blogs'>Blogs</a></li>
	  <li><a href='https://www.haider.gq/repos/repos'>Repositories</a></li>
	  <li><a href='https://www.haider.gq/notes'>Notes</a></li>
	</ul>
	<input type='search' class='Sidebar_Search' placeholder='Search Posts...'>
	</div>

	<div class='grid-item main'>
	  <input type='search' class='Main_Search' placeholder='Search Posts...'>
	      <div class='main-main'> <!-- The actual main part -->"))

;; Set the postamble
(defun dw/site-postamble ()
  (concat "</div>
		    </div>
		<div class='grid-item sidebar'>
		  <h2>Socials</h2>
		  <ul class='sidebar-socials'>
		    <li><a href='mailto:haider@haider.gq'><i class='fa-solid fa-envelope'></i> Email</a></li>
		    <li class='irc' onclick='alert('My Username is Haider,\nYou can find me in Libera.Chat on these channels:\n- #tropin \n- #systemcrafters \n- #guix');'><i class='fa-solid fa-message'></i> IRC/Matrix</li>
		    <li><a href='https://www.github.com/Haider-Mirza'><i class='fa-brands fa-github'></i> Github</a></li>
		  </ul>
		  <h2>Projects</h2>
		  <ul class='sidebar-projects'>
		    <li><a href='https://www.github.com/Haider-Mirza/Spinter'> Spinter</a></li>
		  </ul>
		</div>
		<div class='grid-item footer'>
		  <p>Created by Haider Mirza with orgmode in emacs</p>
		</div>
	      </div>"))


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
             :with-broken-links nil
             :recursive nil
             :with-toc nil
             :section-numbers nil
	     :html-head site-link-href
	     :html-preamble  (dw/site-preamble)
	     :html-postamble (dw/site-postamble)
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-timestamps t
             :time-stamp-file nil)))    ;; Don't include time stamp in file

					; ---------------------------------------------------------------------
					;                          PUBLISH
					; ---------------------------------------------------------------------

(defun my/publish-all()
  (setq org-roam-directory "./content/notes")  ; we first setup the org-roam locations
  (setq org-roam-db-location "./content/roam.db")  ; we first setup the org-roam locations
  (setq org-id-extra-files (org-roam--list-files org-roam-directory)) ; necessary to make link with IDs work
  (org-roam-db-sync t)
  (call-interactively 'org-publish-all))

					; EXTERIOR LINKS -------------------------------------------------
					; Exterior links need to be easily identifiable for readers. They
					; should also open in a new tab.
					; ---
(defun my/format-external-links (text backend info)
  (when (org-export-derived-backend-p backend 'html)
    (when (string-match-p (regexp-quote "http") text)
      (s-replace "<a" "<a target='_blank' rel='noopener noreferrer' class='external'" text))))

(add-to-list 'org-export-filter-link-functions
             'my/format-external-links)
(add-hook 'org-export-before-processing-hook 'my/add-roam-backlinks)

					; --- BACKLINKS ------------------------------------------------------

(defun my/add-roam-backlinks (backend)
  "Insert backlinks at the end of org files. BACKEND."
  (when (org-roam-node-at-point)
    (save-excursion
      (goto-char (point-max))
      (insert "\n* Links to this note\n")
      (my/collect-roam-backlinks backend))))

(defun my/collect-roam-backlinks (backend)
  (when (org-roam-node-at-point)
    (goto-char (point-max))
    ;; Add a new header for the references
    (let* ((backlinks (org-roam-backlinks-get (org-roam-node-at-point))))
      (dolist (backlink backlinks)
        (let* ((source-node (org-roam-backlink-source-node backlink))
               (point (org-roam-backlink-point backlink)))
          (insert
           (format "- [[./%s][%s]]\n"
                   (file-name-nondirectory (org-roam-node-file source-node))
                   (org-roam-node-title source-node))))))))

;; We're using Git, we don't need no steenking backups
(setq make-backup-files nil)
