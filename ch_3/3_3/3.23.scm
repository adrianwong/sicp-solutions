(define (make-deque)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (deque)
      (cons front-ptr rear-ptr))
    (define (set-front-ptr! item)
      (set! front-ptr item))
    (define (set-rear-ptr! item)
      (set! rear-ptr item))
    (define (empty-deque?)
      (null? front-ptr))
    (define (front-deque)
      (if (empty-deque?)
          (error "FRONT called with an empty deque" (deque))
          (caar front-ptr)))
    (define (rear-deque)
      (if (empty-deque?)
          (error "REAR called with an empty deque" (deque))
          (caar rear-ptr)))
    (define (front-insert-deque! item)
      (let ((new-pair (cons (cons item '()) '())))
        (cond ((empty-deque?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               (deque))
              (else
               (set-cdr! (car front-ptr) new-pair)
               (set-cdr! new-pair front-ptr)
               (set-front-ptr! new-pair)
               (deque)))))
    (define (rear-insert-deque! item)
      (let ((new-pair (cons (cons item '()) '())))
        (cond ((empty-deque?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               (deque))
              (else
               (set-cdr! (car new-pair) rear-ptr)
               (set-cdr! rear-ptr new-pair)
               (set-rear-ptr! new-pair)
               (deque)))))
    (define (front-delete-deque!)
      (cond ((empty-deque?)
             (error "FRONT-DELETE! called with an empty deque" (deque)))
            ((null? (cdar rear-ptr))
             (set-front-ptr! '()))
            (else (set-front-ptr! (cdr front-ptr))
                  (set-cdr! (car front-ptr) '())
                  (deque))))
    (define (rear-delete-deque!)
      (cond ((empty-deque?)
             (error "REAR-DELETE! called with an empty deque" (deque)))
            ((null? (cdar rear-ptr))
             (set-front-ptr! '()))
            (else (set-rear-ptr! (cdar rear-ptr))
                  (set-cdr! rear-ptr '())
                  (deque))))
    (define (print-deque)
      (display (map car front-ptr))
      (newline))
    (define (dispatch m)
      (cond ((eq? m 'front-deque) front-deque)
            ((eq? m 'rear-deque) rear-deque)
            ((eq? m 'front-insert-deque!) front-insert-deque!)
            ((eq? m 'rear-insert-deque!) rear-insert-deque!)
            ((eq? m 'front-delete-deque!) front-delete-deque!)
            ((eq? m 'rear-delete-deque!) rear-delete-deque!)
            ((eq? m 'print-deque) print-deque)
            (else (error "Unknown request: MAKE-DEQUE"
                         m))))
    dispatch))

(define d1 (make-deque))

((d1 'front-insert-deque!) 'b)
((d1 'print-deque))
((d1 'front-deque))
((d1 'rear-deque))

((d1 'rear-insert-deque!) 'c)
((d1 'print-deque))
((d1 'front-deque))
((d1 'rear-deque))

((d1 'front-insert-deque!) 'a)
((d1 'print-deque))
((d1 'front-deque))
((d1 'rear-deque))

((d1 'rear-delete-deque!))
((d1 'print-deque))
((d1 'front-deque))
((d1 'rear-deque))

((d1 'front-delete-deque!))
((d1 'print-deque))
((d1 'front-deque))
((d1 'rear-deque))

((d1 'rear-delete-deque!))
((d1 'print-deque))
