(define (deep-reverse lst)
  (if (pair? lst)
      (append (deep-reverse (cdr lst))
              (list (deep-reverse (car lst))))
      lst))
