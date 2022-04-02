(define (strip-right str pred)
  (substring-cursor str
                    (string-find str pred)))

(define (strip-left str pred)
  (substring-cursor str
                    (string-cursor-start str)
                    (string-find str pred)))

(define (string-trim-upto str pred)
  (let ((i (string-find str pred))
        (end (string-cursor-end str)))
    (if (string-cursor=? i end) ""
      (substring-cursor str
                        (string-cursor-next str i)
                        end))))

(define (first-char str)
  (string-cursor-ref str
                     (string-cursor-start str)))

(define (chars c n)
  (take (circular-list c) n))

(define (strip-whitespace str)
  (strip-right str
               (char-set #\  #\	)))

(define (string-prev-ref str i)
  (string-cursor-ref str
                     (string-cursor-prev str i)))

(define (substring-cursor-next str i . o)
  (apply
   substring-cursor
   str
   (cons
    (string-cursor-next str i)
    o)))

(define (string-lit? str i)
  (let ((j (string-cursor-prev str i))
         (st (string-cursor-start str)))
    (cond
      ((string-cursor<=? j st) #f)
      ((eq? #\\ (string-cursor-ref str j))
        (let ((k (string-cursor-prev str j)))
          (if (and (string-cursor>? k st)
                   (eq? #\\ (string-cursor-ref str k)))
            (string-lit? str k)
            #f)))
    (else #t))))

(define (string-nonlit? str i) (not (string-lit? str i)))

(define (string-find+ str c p)
  (let loop ((cur str) (idx 0))
    (if (eq? c (first-char cur))
      (string-cursor-start str)
      (let ((i (string-find cur c))
             (end (string-cursor-end cur)))
        (cond
          ((string-cursor>=? i end)
           (string-cursor-end str))
          ((p cur i)
           (loop
            (substring-cursor-next cur i end)
            (+ idx (string-cursor->index cur i))))
          (else
            (string-index->cursor str
             (+ idx (string-cursor->index cur i)))))))))

(define (string-find-nonlit str c)
  (string-find+ str
                c
                string-nonlit?))

(define (string-cursor+index str i n)
  (string-index->cursor str
   (+ n
    (string-cursor->index str i))))

(define (string-cursor-diff str i j)
  (abs
   (-
    (string-cursor->index str j)
    (string-cursor->index str i))))

(define (string-unqoute str)
  (let loop ((cur str)
              (res ""))
    (let ((i (string-find cur #\")))
      (cond
        ((string-null? cur) res)
        ((string-cursor=? i
                          (string-cursor-end cur))
         (string-append res cur))
        (else
          (loop
           (string-trim-upto
            (substring-cursor cur
                              (string-cursor-next cur i))
             #\")
           (string-append res
                   (substring-cursor cur
                                     (string-cursor-start cur)
                                     i))))))))
