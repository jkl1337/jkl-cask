;;; test-simple-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (test-simple-clear test-simple-start) "test-simple"
;;;;;;  "test-simple.el" (21302 2894 738464 168000))
;;; Generated autoloads from test-simple.el

(autoload 'test-simple-start "test-simple" "\


\(fn &optional TEST-START-MSG)" nil t)

(autoload 'test-simple-clear "test-simple" "\
Initializes and resets everything to run tests. You should run
this before running any assertions. Running more than once clears
out information from the previous run.

\(fn &optional TEST-INFO TEST-START-MSG)" t nil)

;;;***

;;;### (autoloads nil nil ("test-simple-pkg.el") (21302 2894 757963
;;;;;;  11000))

;;;***

(provide 'test-simple-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; test-simple-autoloads.el ends here
