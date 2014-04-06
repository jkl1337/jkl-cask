;;; company-jedi-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (company-jedi-eldoc-mode company-jedi-mode company-jedi
;;;;;;  company-jedi-install company-jedi-stop company-jedi-start)
;;;;;;  "company-jedi" "company-jedi.el" (21279 7489 326138 101000))
;;; Generated autoloads from company-jedi.el

(autoload 'company-jedi-start "company-jedi" "\
Start remote jedi server.

\(fn)" t nil)

(autoload 'company-jedi-stop "company-jedi" "\
Stop remote jedi server.

\(fn)" t nil)

(autoload 'company-jedi-install "company-jedi" "\
Install jedi dependencies with pip.  Virtualenv required.

\(fn)" t nil)

(autoload 'company-jedi "company-jedi" "\
Jedi backend for company-mode.

See `company-backends' for more info about COMMAND and ARG.

\(fn COMMAND &optional ARG)" t nil)

(autoload 'company-jedi-mode "company-jedi" "\
Minor mode for Company Jedi interaction.

\\{company-jedi-mode-map}

\(fn &optional ARG)" t nil)

(autoload 'company-jedi-eldoc-mode "company-jedi" "\
Eldoc mode for company-jedi backend.

\\{company-jedi-eldoc-mode-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil nil ("company-jedi-pkg.el") (21279 7489 627748
;;;;;;  813000))

;;;***

(provide 'company-jedi-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; company-jedi-autoloads.el ends here
