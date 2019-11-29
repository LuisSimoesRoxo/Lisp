
(defun c:pt_b  ( / pt1 xpt1 ypt1 pt1info pt2 xpt2 ypt2 pt2info findang pt3 lateral1)
 
 ;variáveis
 (setvar "osmode" 131) ;activa mid e end point
(setvar "cmdecho" 0)
;auxiliar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;NOTA1
(command "layer" "M" "Portas_b" "") ;cria o layer Portas_b, para alterar onde está "Portas_b" coloca o nome que pretenderes. ex "Porta_xxxxxxxxxx"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FIM NOTA1
;programa principal
(setq pt1 (getpoint "\n...::clique ponto de origem da porta >"))
   	(setq xpt1 (car pt1))
	(setq ypt1 (cadr pt1))
    (setq pt1info (strcat (rtos xpt1 2 3) "," (rtos ypt1 2 3)))
(princ pt1info)

(setq pt2 (getpoint pt1 "\n...::clique canto oposto para definir largura da porta >"))
   	(setq xpt2 (car pt2))
	(setq ypt2 (cadr pt2))
    (setq pt2info (strcat (rtos xpt2 2 3) "," (rtos ypt2 2 3)))
(princ pt2info)
         (command "dist" pt1info pt2info)
         (setq ssdist1to2 (getvar "distance"))
         (setq npx1to2 (rtos ssdist1to2 2 9))
		 
		; (alert npx1to2)

(setq findang (getangle pt1 (strcat "\...::clique na esquina da parede, sentido de abertura para angulo >")) )
(setq lateral1 (strcat (rtos (- (* findang 57.29578) 90)2 1)))

;(alert lateral1)
(setq pt3 (getpoint pt1 "\n...::clique na esquina da parede, sentido contrario de abertura para angulo >"))	 

(command "-insert" "porta" pt1info npx1to2 npx1to2 lateral1)



(setq valida  (getstring (strcat "\n...::porta inserida corretamente ENTER-sim; N-não>")));setq
	 
	(if (or (= valida "N")(= valida "n"))
   (progn
     (active_f))
   (progn
   (alert "TANKS."))
   );fim if

);fim defun


(defun active_f ( / active_porta)
(setvar "cmdecho" 0)

   (setq active_porta (ssget "l" ))

(command "_.mirror" active_porta "" pt1 pt3 "y")

);fim active_f