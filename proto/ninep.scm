(define (ninep-read n)
  (call-with-process-io
   (list "9p"
         "read"
         n)
   (lambda (pid in out err)
     (port->string out))))

(define (ninep-acme-read n)
  (ninep-read (string-append "acme/"
                             n)))

(define (ninep-awin-read n)
  (ninep-acme-read (string-append "$WINID/"
                                  n)))

(define (ninep-write n str)
  (call-with-process-io
    (list "9p"
          "write"
          n)
    (lambda (pid in out err)
      (write-string str))))

(define (ninep-acme-write n str)
  (ninep-write (string-append "acme/"
                               n)
                str))

(define (ninep-awin-write n str)
  (ninep-acme-write (string-append "$WINID/"
                                   n)
                    str))
