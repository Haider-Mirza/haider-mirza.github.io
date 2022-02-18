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

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-preamble  #'dw/site-header
      org-html-postamble #'dw/site-footer
      org-html-metadata-timestamp-format "%Y-%m-%d"
      org-html-html5-fancy nil
      org-html-htmlize-output-type 'css
      org-html-self-link-headlines t
      org-html-validation-link nil
      org-html-doctype "html5"
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://www.haider.gq/base/stylesheet.css\"/>")


(setq org-publish-use-timestamps-flag t
      org-publish-timestamp-directory "./.org-cache/"
      org-export-with-section-numbers nil
      org-export-use-babel nil
      org-export-with-smart-quotes t
      org-export-with-sub-superscripts nil
      org-export-with-tags 'not-in-toc
      org-export-with-toc t)

(setq dw/site-url "https://www.haider.gq")
(setq dw/site-title   "Haider.gq")
(setq dw/site-tagline "")

(defun dw/site-header (info)
  (let* ((file (plist-get info :output-file)))
    `(div (div (@ (class "blog-header"))
               (div (@ (class "container"))
                    (div (@ (class "row align-items-center justify-content-between"))
                         (div (@ (class "col-sm-12 col-md-8"))
                              (div (@ (class "blog-title"))
                                   ,dw/site-title))
                         (div (@ (class "col-sm col-md"))
                              (div (@ (class "blog-description text-sm-left text-md-right text-lg-right text-xl-right"))
                                   ,dw/site-tagline)))))

          (div (@ (class "blog-masthead"))
               (div (@ (class "container"))
                    (div (@ (class "row align-items-center justify-content-between"))
                         (div (@ (class "col-sm-12 col-md-12"))
                              (nav (@ (class "nav"))
                                   (a (@ (class "nav-link") (href "/")) "Home") " "
                                   ;; (a (@ (class "nav-link") (href "/articles")) "Articles")
                                   (a (@ (class "nav-link") (href "/videos")) "Videos") " "
                                   (a (@ (class "nav-link") (href "https://wiki.systemcrafters.net")) "Wiki") " "
                                   (a (@ (class "nav-link") (href "https://store.systemcrafters.net?utm_source=sc-site-nav")) "Merch Store") " "
                                   (a (@ (class "nav-link") (href "/support-the-channel")) "Support The Channel")))))))))

(defun dw/site-footer (info)
  (list
   `(footer (@ (class "blog-footer"))
            (div (@ (class "container"))
                 (div (@ (class "row"))
                      (div (@ (class "col-sm col-md text-sm-left text-md-right text-lg-right text-xl-right"))
                           (p "Made with " ,(plist-get info :creator))
                           (p (a (@ (href ,(concat dw/site-url "/privacy-policy/"))) "Privacy Policy"))))))
   `(script (@ (src "/js/bootstrap.bundle.min.js")))))

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc nil                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :with-timestamps t
             :time-stamp-file nil)))    ;; Don't include time stamp in file

;; We're using Git, we don't need no steenking backups
(setq make-backup-files nil)

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
