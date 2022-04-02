(define (ninep-read . a)
  (call-with-process-io
   (cons "9p" (cons "read" a))
   (lambda (pid in out err)
     (port->string out))))

(define (ninep-write . a)
  (call-with-process-io
   (cons "9p"
    (cons "write"
     (drop-right a 1)))
   (lambda (pid in out err)
     (write-string (last a)))))
