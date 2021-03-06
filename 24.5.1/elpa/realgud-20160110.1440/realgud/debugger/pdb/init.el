;; Copyright (C) 2015 Free Software Foundation, Inc

;; Author: Rocky Bernstein <rocky@gnu.org>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; Stock Python debugger pdb

(eval-when-compile (require 'cl))

(require 'load-relative)
(require-relative-list '("../../common/regexp"
			 "../../common/loc"
			 "../../common/init")
		       "realgud-")
(require-relative-list '("../../lang/python") "realgud-lang-")

(defvar realgud-pat-hash)
(declare-function make-realgud-loc-pat (realgud-loc))

(defvar realgud:pdb-pat-hash (make-hash-table :test 'equal)
  "Hash key is the what kind of pattern we want to match:
backtrace, prompt, etc.  The values of a hash entry is a
realgud-loc-pat struct")

(declare-function make-realgud-loc "realgud-loc" (a b c d e f))

;; Regular expression that describes a pdb location generally shown
;; before a command prompt.
;;
;; Program-location lines look like this:
;;   > /usr/bin/zonetab2pot.py(15)<module>()
;; or MS Windows:
;;   > c:\\mydirectory\\gcd.py(10)<module>
(setf (gethash "loc" realgud:pdb-pat-hash)
      (make-realgud-loc-pat
       :regexp "^> \\(\\(?:[a-zA-Z]:\\)?[-a-zA-Z0-9_/.\\\\ ]+\\)(\\([0-9]+\\))"
       :file-group 1
       :line-group 2))

(setf (gethash "prompt" realgud:pdb-pat-hash)
      (make-realgud-loc-pat
       :regexp   "^[(]+Pdb[)]+ "
       ))

;;  Regular expression that describes a Python backtrace line.
(setf (gethash "lang-backtrace" realgud:pdb-pat-hash)
      realgud-python-backtrace-loc-pat)

;;  Regular expression that describes location in a pytest error
(setf (gethash "pytest-error" realgud:pdb-pat-hash)
      realgud-pytest-error-loc-pat)

;;  Regular expression that describes a "breakpoint set" line. For example:
;;     Breakpoint 1 at /usr/bin/pdb:7
(setf (gethash "brkpt-set" realgud:pdb-pat-hash)
      (make-realgud-loc-pat
       :regexp "^Breakpoint \\([0-9]+\\) at[ \t\n]+\\(.+\\):\\([0-9]+\\)\\(\n\\|$\\)"
       :num 1
       :file-group 2
       :line-group 3))

;;  Regular expression that describes a "delete breakpoint" line
(setf (gethash "brkpt-del" realgud:pdb-pat-hash)
      (make-realgud-loc-pat
       :regexp "^Deleted breakpoint \\([0-9]+\\)\n"
       :num 1))

(setf (gethash "font-lock-keywords" realgud:pdb-pat-hash)
      '(
	;; The frame number and first type name, if present.
	("^\\(->\\|##\\)\\([0-9]+\\) \\(<module>\\)? *\\([a-zA-Z_][a-zA-Z0-9_]*\\)(\\(.+\\))?"
	 (2 realgud-backtrace-number-face)
	 (4 font-lock-function-name-face nil t))     ; t means optional.

	;; Parameter sequence, E.g. gcd(a=3, b=5)
	;;                             ^^^^^^^^^
	("(\\(.+\\))"
	 (1 font-lock-variable-name-face))

	;; File name. E.g  file '/test/gcd.py'
	;;                 ------^^^^^^^^^^^^-
	("[ \t]+file '\\([^ ]+*\\)'"
	 (1 realgud-file-name-face))

	;; Line number. E.g. at line 28
        ;;                  ---------^^
	("[ \t]+at line \\([0-9]+\\)$"
	 (1 realgud-line-number-face))

	;; Function name.
	("\\<\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\.\\([a-zA-Z_][a-zA-Z0-9_]*\\)"
	 (1 font-lock-type-face)
	 (2 font-lock-function-name-face))
	;; (pdb-frames-match-current-line
	;;  (0 pdb-frames-current-frame-face append))
	))

(setf (gethash "pdb" realgud-pat-hash) realgud:pdb-pat-hash)

(defvar realgud:pdb-command-hash (make-hash-table :test 'equal)
  "Hash key is command name like 'shell' and the value is
  the pdb command to use, like 'python'")

(setf (gethash "shell" realgud:pdb-command-hash) "python")
(setf (gethash "eval"  realgud:pdb-command-hash) "p %s")
(setf (gethash "pdb" realgud-command-hash) realgud:pdb-command-hash)

(provide-me "realgud:pdb-")
