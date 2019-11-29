(defun c:blat (/ ss att ent txtread)
  (setvar "cmdecho" 0)
   (setq ent (ssget "X" (list (cons 0 "text"))))
   (setq n (sslength ent))
   (repeat n
(prompt "\n...Texto")
   (setq ent (ssget ":S" (list (cons 0 "text"))))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq txtread (cdr (assoc 1 (entget temp))))
(COMMAND "_.ERASE" ent "")

(prompt "\n...Bloco")
  (if (setq ss (ssget ":S" (list (cons 0 "INSERT")(cons 2 "PARCELA")
       (cons 66 1)(if (getvar "CTAB")(cons 410 (getvar "CTAB"))
              (cons 67 (- 1 (getvar "TILEMODE")))))))
    (progn
      (foreach ent (mapcar 'cadr (ssnamex ss))
    (setq att (entnext ent))
    (while (not (eq "SEQEND" (cdadr (entget att))))
      (cond ((eq "PREDIO" (cdr (assoc 2 (entget att))))
         (entmod (subst (cons 1 txtread) (assoc 1 (entget att)) (entget att))))


        ((eq "PARCELA" (cdr (assoc 2 (entget att))))
         (entmod (subst (cons 1 "1") (assoc 1 (entget att)) (entget att)))))
      (setq att (entnext att))))
      (command "_regenall"))
    (princ "\n<!> No Blocks Found <!>")))
  (princ))
  
  
  
(defun c:blat1 (/ ss att ent txtread)
  (setvar "cmdecho" 0)
   (setq ent (ssget "X" (list (cons 0 "text"))))
   (setq n (sslength ent))
   (repeat n
(prompt "\n...Texto")
   (setq ent (ssget ":S" (list (cons 0 "text"))))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq txtread (cdr (assoc 1 (entget temp))))
;(COMMAND "_.ERASE" ent "")

(prompt "\n...Bloco")
  (if (setq ss (ssget ":S" (list (cons 0 "INSERT")
       (cons 66 1)(if (getvar "CTAB")(cons 410 (getvar "CTAB"))
              (cons 67 (- 1 (getvar "TILEMODE")))))))
    (progn
      (foreach ent (mapcar 'cadr (ssnamex ss))
    (setq att (entnext ent))
    (while (not (eq "SEQEND" (cdadr (entget att))))
      (cond ((eq "FOLHA" (cdr (assoc 2 (entget att))))
         (entmod (subst (cons 1 txtread) (assoc 1 (entget att)) (entget att)))))
      (setq att (entnext att))))
      (command "_regenall"))
    (princ "\n<!> No Blocks Found <!>")))
  (princ))
  
  
******************************
(defun C:blattt ( / Oldtxtreadnumero OldCodArteria txtreadnumero PtInsercao *error* )
  	
	(setvar "cmdecho" 0)
  	(setq enp 1)
  	
	(if (= txtreadnumero nil) (setq txtreadnumero "1"))

 	(setq Oldtxtreadnumero txtreadnumero) 
  	(setq PtInsercao '(0 0))  
 	(while PtInsercao 
	
		(setq txtreadnumero (getstring 1 (strcat "\nNúmero da Parcela <" Oldtxtreadnumero ">: ")))
		(if (= txtreadnumero "") (setq txtreadnumero Oldtxtreadnumero))
		(setq Oldtxtreadnumero (itoa (+ (atoi txtreadnumero) 1)))

	
(prompt "\n...Escolha o Bloco")
  (if (setq ss (ssget ":S" (list (cons 0 "INSERT")(cons 2 "SABOR")
       (cons 66 1)(if (getvar "CTAB")(cons 410 (getvar "CTAB"))
              (cons 67 (- 1 (getvar "TILEMODE")))))))
    (progn
      (foreach ent (mapcar 'cadr (ssnamex ss))
    (setq att (entnext ent))
    (while (not (eq "SEQEND" (cdadr (entget att))))
      (cond 
        ((eq "NPROJECTO" (cdr (assoc 2 (entget att))))
         (entmod (subst (cons 1 txtreadnumero) (assoc 1 (entget att)) (entget att)))))
      (setq att (entnext att))))
      (command "_regenall"))
    (princ "\n<!> No Blocks Found <!>"))))
  (princ)