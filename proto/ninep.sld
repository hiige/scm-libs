(define-library (scm proto ninep)
 (export ninep-write ninep-read)
  (import
   (chibi) (chibi io)
   (chibi process) (srfi 1))
 (include "ninep.scm"))
