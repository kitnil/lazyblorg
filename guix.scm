;;; GNU Guix --- Guix package for lazyblorg
;;; Copyright © 2020 Oleg Pykhalov <go.wigust@gmail.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This file contains Guix package for development version of
;; lazyblorg.  To build or install, run:
;;
;;   guix build --file=guix.scm
;;   guix package --install-from-file=guix.scm

;; The main purpose of this file though is to make a development
;; environment for building lazyblorg.:
;;
;;   guix environment --pure --load=guix.scm

;;; Code:

(use-modules (gnu packages python-web)
             (gnu packages python-xyz)
             (guix build-system python)
             (guix build utils)
             (guix gexp)
             (guix git-download)
             ((guix licenses) #:prefix license:)
             (guix packages)
             (ice-9 popen)
             (ice-9 rdelim))

(define %source-dir (dirname (current-filename)))

(define (git-output . args)
  "Execute 'git ARGS ...' command and return its output without trailing
newspace."
  (with-directory-excursion %source-dir
    (let* ((port   (apply open-pipe* OPEN_READ "git" args))
           (output (read-string port)))
      (close-pipe port)
      (string-trim-right output #\newline))))

(define (current-commit)
  (git-output "log" "-n" "1" "--pretty=format:%H"))

(define-public python-orgformat
  (let ((commit "13047394fb867963a8d4e8120960f3298863f063")
        (revision "1"))
    (package
      (name "python-orgformat")
      (version (git-version "2019.12.29.1" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/novoid/orgformat")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0d42ii3y1md39ahh05xxnmp7qzi0a456a8xjwc34ik1jl7scqrsr"))))
      (build-system python-build-system)
      (home-page "https://github.com/novoid/orgformat/")
      (synopsis "Python library for Org mode parsing")
      (description "This is a utility library for providing functions to
generate and modify Org mode syntax elements like headings, links,
time-stamps, or date-stamps.")
      (license license:gpl3+))))

(define-public lazyblorg
  (let ((commit (current-commit))
        (revision "1"))
    (package
      (name "lazyblorg")
      (version (git-version "0.0.1" revision commit))
      (source (local-file %source-dir
                          #:recursive? #t
                          #:select? (git-predicate %source-dir)))
      (inputs
       `(("orgformat" ,python-orgformat)
         ("python-pypandoc" ,python-pypandoc)
         ("python-werkzeug" ,python-werkzeug)))
      (build-system python-build-system)
      (home-page "https://github.com/novoid/lazyblorg/")
      (synopsis "Blogging with Org-mode for very lazy people")
      (description "This package provides a web blog environment for GNU Emacs
with Org-mode which generates static HTML5 web pages.")
      (license license:gpl3+))))

lazyblorg
