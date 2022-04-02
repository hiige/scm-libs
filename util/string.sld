(define-library (scm util string)
  (export strip-right strip-left string-trim-upto
   first-char chars strip-whitespace string-prev-ref
   substring-cursor-next string-lit? string-nonlit?
   string-find+ string-find-nonlit string-cursor+index
   string-cursor-diff string-unqoute)
  (import
   (chibi) (chibi string)
   (chibi char-set) (srfi 1))
  (include "string.scm"))
