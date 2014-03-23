;;; Copyright (C) 2011-2014 Rocky Bernstein <rocky@gnu.org>
;;; Perl trepanning Debugger tracking a comint buffer.

(eval-when-compile (require 'cl))
(require 'load-relative)
(require-relative-list '(
                         "../../common/cmds"
                         "../../common/menu"
                         "../../common/track"
                         "../../common/track-mode"
                         )
                       "realgud-")
(require-relative-list '("core" "init") "realgud-trepanpl-")
(require-relative-list '("../../lang/ruby") "realgud-lang-")

(realgud-track-mode-vars "realgud-trepanpl")

(declare-function realgud-goto-line-for-pt   'realgud-track-mode)
(declare-function realgud-track-mode         'realgud-track-mode)
(declare-function realgud-track-mode-hook    'realgud-track-mode)
(declare-function realgud-track-mode-setup   'realgud-track-mode)
(declare-function realgud-track-set-debugger 'realgud-track-mode)
(declare-function realgud-perl-populate-command-keys 'realgud-lang-perl)


(defun realgud-trepanpl-goto-syntax-error-line (pt)
  "Display the location mentioned in a Syntax error line
described by PT."
  (interactive "d")
  (realgud-goto-line-for-pt pt "syntax-error"))

(define-key realgud-trepanpl-track-mode-map
  (kbd "C-c !s") 'realgud-trepanpl-goto-syntax-error-line)

(realgud-perl-populate-command-keys realgud-trepanpl-track-mode-map)

(defun realgud-trepanpl-track-mode-hook()
  (if realgud-trepanpl-track-mode
      (progn
        (use-local-map realgud-trepanpl-track-mode-map)
        (message "using trepanpl mode map")
        )
    (message "trepan.pl track-mode-hook disable called"))
)

(define-minor-mode realgud-trepanpl-track-mode
  "Minor mode for tracking trepan.pl source locations inside a process shell via realgud. trepan.pl is a Perl debugger see URL `https://metacpan.org/pod/Devel::Trepan'.

If called interactively with no prefix argument, the mode is toggled. A prefix argument, captured as ARG, enables the mode if the argument is positive, and disables it otherwise.

\\{trepanpl-track-mode-map}
"
  :init-value nil
  ;; :lighter " trepanpl"   ;; mode-line indicator from realgud-track is sufficient.
  ;; The minor mode bindings.
  :global nil
  :group 'trepanpl
  :keymap realgud-trepanpl-track-mode-map

  (realgud-track-set-debugger "trepan.pl")
  (if realgud-trepanpl-track-mode
      (progn
        (realgud-track-mode-setup 't)
        (realgud-trepanpl-track-mode-hook))
    (progn
      (setq realgud-track-mode nil)
      ))
)

(provide-me "realgud-trepanpl-")