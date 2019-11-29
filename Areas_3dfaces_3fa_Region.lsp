(defun c:faceArea.lsp ( / myerror olderror 
                          ss en ed p1 p2 p3 p4 area3p fArea zzponto )
;;------- subroutines --------
 
(defun area3p (p1 p2 p3 / a b c s)
(setq
    a (distance p1 p2)
    b (distance p2 p3)
    c (distance p3 p1)
    s (* 0.5 (+ a b c))
)
(sqrt
    (*
        s
        (- s a)
        (- s b)
        (- s c)
    )
)
)
;;=========== main routine ===============
 
 (setq x 0)
 (setq totarea 0.0) 
 (setq ss (ssget  '((0 . "3DFACE"))))
(setq y  (sslength ss))  
        
(If   (=  ss nil)
(progn 
  (Getstring  "\nNo 3d faces . Press any key when ready ")
  (exit)
)
)
(setq y  (sslength ss))  
(repeat y
        (setq en (ssname ss x)
              ed (entget en)
              p1 (cdr (assoc 10 ed))
              p2 (cdr (assoc 11 ed))
              p3 (cdr (assoc 12 ed))
              p4 (cdr (assoc 13 ed))
              )
        (setq fArea (+ (area3p p1 p2 p3) (area3p p3 p4 p1)))
        (setq totarea (+ totarea farea))
        (princ "\nArea: ") (princ totArea) (princ)
           
      (setq x (+ x 1))
) ; repeat
(setq zzponto (getpoint "\n...Colocar Área: "))
(command "_.text" zzponto "0" (strcat (rtos totArea 2 0) " m²"))
)  ;defun
(defun c:3fa ()
  (c:facearea)
)
(princ "FACEAREA loaded. Type FACEAREA or 3FA to run.")

(princ)


;;;;;3Dfaces para polylines várias ao mesmo tempo
(defun C:3DFtoPL(/ ss1 sl i) 
  (setq ss1 (ssget  (list (cons '0 "3DFACE")))) 
  (setq sl (sslength ss1)) 
  (setq i 0) 
  (while (< i sl) 
     (setq ent1 (entget (setq e1 (ssname ss1 i)))) 
	 (setq layr (cdr (assoc  '8 ent1)))
     (command "layer" "set" layr "")
		 ;(alert layr)
     (setq pt1 (cdr (assoc '10 ent1))) 
     (setq pt2 (cdr (assoc '11 ent1))) 
     (setq pt3 (cdr (assoc '12 ent1))) 
     (setq pt4 (cdr (assoc '13 ent1))) 
     ;  Plain 2D Polylines 
     (command "PLINE" pt1 pt2 pt3) 
     ; 3dPolylines -> 
     ;(command "3DPOLY" pt1 pt2 pt3) 
     (if (/= pt3 pt4) (command pt4 "c") (command "c") ) 
     (entdel e1) 
     (setq i (1+ i)) 
  ) 
  (setq ss1 nil) 
  (princ) 
) 

(princ "\nC:3DFtoPL loaded, to run type 3DFtoPL.") 
(princ)




;Solidos para polylines
(defun c:sol2pol(/ solid pt1 pt2 pt3 pt4)

        (setvar 'cmdecho 1)
   (prompt "\nPlease select the solid you want to outline.")
   (WHILE (NOT (setq solid (ssget ":S" '((0 . "SOLID")))))
      (prompt "\nPlease select the solid you want to outline."))
	  
  (setq layr (cdr (assoc  8 (entget (ssname solid 0)))))
  (command "layer" "set" layr "")
		 ;(alert layr)
		 
      (SETQ pt1 (cdr (assoc 10 (entget (ssname solid 0))))
         pt2 (cdr (assoc 11 (entget (ssname solid 0))))
         pt3 (cdr (assoc 12 (entget (ssname solid 0))))
         pt4 (cdr (assoc 13 (entget (ssname solid 0))))
       );SETQ
   (COMMAND "_.PLINE" PT1 PT2 PT4 PT3 "C")
   ;(command ".erase" solid "")
);DEFUN
;;;;;Solidos para polylines melhor
(defun C:sol2pol1(/ ss1 sl i pt1 pt2 pt3 pt4) 
  (setq ss1 (ssget  (list (cons '0 "SOLID")))) 
  (setq sl (sslength ss1)) 
  (setq i 0) 
  (while (< i sl) 
     (setq ent1 (entget (setq e1 (ssname ss1 i)))) 
	 (setq layr (cdr (assoc '8 ent1)))
     (command "layer" "set" layr "")
		 (alert layr)
     (setq pt1 (cdr (assoc '10 ent1))) 
     (setq pt2 (cdr (assoc '11 ent1))) 
     (setq pt3 (cdr (assoc '12 ent1))) 
     (setq pt4 (cdr (assoc '13 ent1))) 
     ;  Plain 2D Polylines 
     (command "PLINE" pt1 pt2 pt4) 
     ; 3dPolylines -> 
     ;(command "3DPOLY" pt1 pt2 pt3) 
     (if (/= pt4 pt3) (command pt3 "c") (command "c") ) 
     (entdel e1) 
     (setq i (1+ i)) 
  ) 
  (setq ss1 nil) 
  (princ) 
) 

(princ "\nC:3DFtoPL loaded, to run type 3DFtoPL.") 
(princ)







;;;;;Regioes para polylines uma de cada vez, pode demorar muito tempo
(defun c:reg2poly ( / ename old_cmdecho)
  
  (setq ename ename2)
  
(if (setq ename (car (entsel))) (if (= (cdr (assoc 0 (entget ename))) "REGION")
      
(progn
        (setq old_cmdecho (getvar 'cmdecho))
        (setvar 'cmdecho 0)
        (command "_.undo" "_begin")
        (command "_.explode" ename)
        (command "_.pedit" "_m" (ssget "_p") "" "_y" "_j" 0.0 "")
        
(command "_.undo" "_end")
        (setvar 'cmdecho old_cmdecho)
      
)
      (prompt "\nThe selected object is not a region.")
    )
    (prompt "\nNothing selected.")
  )
  (princ)
)
;;;;;Regioes para polylines várias ao mesmo tempo, pode demorar muito tempo
(defun C:reg2poly1 (/ ss1 sl i) 

        (setvar 'cmdecho 0)
  (setq ss1 (ssget (list (cons '0 "REGION")))) 
  (setq sl (sslength ss1)) 
  (setq i 0) 
  (while (< i sl) 
     (setq ent1 (entget (setq e1 (ssname ss1 i)))) 

        (command "_.explode" ss1)
        (command "_.pedit" "m" "p" "" "y" "j" 0.0 "")	 
	 
	 
     (setq i (1+ i)) 
  ) 
  (setq ss1 nil) 
  (princ) 
)



;;;;;SOLIDOS PARA REGIOES, REGIOES PARA POLILINHAS
(defun C:SOL2REG (/ ss1) 
        (setvar 'cmdecho 0)
		
  (setq ss1 (ssget (list (cons '0 "SOLID")))) 
     (setq ent1 (entget (setq e1 (ssname ss1 0)))) 
	 (setq layr (cdr (assoc '8 ent1)))
     (command "layer" "set" layr "")
        (command "_.region" ss1 "")	 
     (command "layer" "set" 0 "")
 (princ) 
)









