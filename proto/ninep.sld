(define-library (scm proto ninep)
 (export ninep-write ninep-read
   ninep-acme-write ninep-acme-read
   ninep-awin-write ninep-awin-read)
  (import
   (chibi) (chibi io)
   (chibi process) (srfi 1))
 (include "ninep.scm"))
