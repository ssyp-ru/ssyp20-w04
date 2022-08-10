
(defmacro delay (aexpr)
 (if (null aexpr) nil `(lambda nil ,aexpr)))

(defun force (delayed-object)
 (if (null delayed-object) nil (funcall delayed-object)))

(defmacro cons! (a b)
  `(cons ,a (delay ,b)))

(defun car! (x) (car x))

(defun cdr! (x) (force (cdr x)))

(defun nth! (s n)
  (if (zerop n) (car! s) (nth! (cdr! s) (- n 1))))

(defun map! (f s)
  (if (null s) nil (cons! (funcall f (car! s)) (map! f (cdr! s)))))

(defun for-each! (f s)
  (if (null s) 'ok (progn (funcall f (car! s)) (for-each! f (cdr! s)))))

(defun filter! (pred s)
  (cond ((null s) nil)
        ((funcall pred (car! s)) (cons! (car! s) (filter! pred (cdr! s))))
        (t (filter! pred (cdr! s)))))
  
(defun enum-interval! (start finish)
  (if (> start finish) nil (cons! start (enum-interval! (+ 1 start) finish))))

(defun enum-inf! (&optional (start 1))
  (cons! start (enum-inf! (+ start 1))))

(defun enum-fib! (p c)
  (cons! p (enum-fib! c (+ p c))))
  
(defun take! (n s)
  (if (zerop n) nil (cons (car s) (take! (- n 1) (cdr! s)))))  

(defun enum-prime! nil
  (filter! 'primep (enum-inf! 1)))

(defun mapcar! (f &rest ss)
  (let ((a (apply f (mapcar 'car! ss)))
        (d (mapcar 'cdr! ss)))
     (cons! a (apply 'mapcar! (cons f d)))))

(defun part-sum! (s &optional (acc 0))
  (let ((accn (+ acc (car! s)))) 
    (cons! accn (part-sum! (cdr! s) accn))))

(defun part-prod! (s &optional (acc 1))
  (let ((accn (* acc (car! s)))) 
    (cons! accn (part-prod! (cdr! s) accn))))

(defun uni-rec! (f &rest x)
  (let ((x-next (apply f x)))
        (cons! (car (last x))  (apply 'uni-rec! (cons f (append (cdr x) (list x-next))))))) 

(defun iterate! (f x)
  (cons! x (iterate! f (funcall f x))))

;;  
;;
;;(setq *s* (cons! (+ 0 1) (cons! (+ 1 2) (cons! (+ 2 3) (cons! (+ 3 4) nil)))))
;;(setq *q* (map! (lambda (x) (* x x)) *s*))
;;(take! 10 (enum-fib! 1 1))
;;==> (1 1 2 3 5 8 13 21 34 55)
;;(take! 10 (filter! (lambda (x) (zerop (% x 7))) (enum-inf! 1)))
;;==> (7 14 21 28 35 42 49 56 63 70)  
;;(take! 20 (enum-prime!))
