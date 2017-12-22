(define (lookup given-key set-of-records)
  (let ((entry-key (key (entry set-of-records))))
    (cond ((null? set-of-records) false)
          ((= given-key entry-key)
           (entry set-of-records))
          ((< given-key entry-key)
           (lookup given-key (left-branch set-of-records)))
          ((> given-key entry-key)
           (lookup given-key (right-branch set-of-records))))))
