(defun c:du2 ( / entin duvida duvidas ent n temp L C C1 C2 PINS ptanalisacoor fil)

   (setvar "cmdecho" 0)
   	;(setq duvidas (getstring t "\n...:Tipo de Limpeza:... >"))
	;(if (= duvidas "") (setq duvidas "01"))
	
	(prompt "\nSelecionar elemento para análise:")
	(setq ent (ssget "+.:S" ))
	(setq n (sslength ent))

   (setq temp (ssname ent (setq n (- n 1))))
   (setq L (cdr (assoc 8 (entget temp))))
   (setq C (cdr (assoc 10 (entget temp))))
   (setq C1 (rtos (car C) 2 4))
   (setq C2 (rtos (cadr C) 2 4))
     (setq C3 (rtos (caddr C) 2 4))
   (setq PINS (strcat C1 "," C2 "," C3))
	
		   ;(command "-mapclean" (strcat "C:/#Temp/Limpeza_02.dpf"))
		   
		      	;(setq duvidas (getstring t "\n...:Tipo de Limpeza:... >"))
				;(if (= duvidas "") (command "-maptopocreate" (substr L 1 8) "" "P" "" "" "all" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" ""))
		     	(setq duvida (getstring t "\n...:Descrição da Dúvida:... >"))
	(setq ptanalisacoor (strcat "COORDENADA: " PINS "		LAYER: " L	"		L01**DESCRIÇÃO: " duvida))

	    (setq fil (open "C:/#Temp/GEOLAYER-DUVIDAS.txt" "a"))
		    (princ ptanalisacoor fil)
			   (princ "\n" fil)
	    (close fil)
		;(command "convert" "" "")
;(command "-layer" "f" L "lo" L "")
(alert ptanalisacoor)
(princ)
)


(defun c:du ( / ptanalisa ptanalisacoor duvida fil)

   (setvar "cmdecho" 0)
      (setvar "osmode" 73)

	(setq ptanalisa (getpoint "\n...:Ponto de Analise:..."))
	(setq duvida (getstring t "\n...:Descrição da Dúvida:... >"))

	(setq ptanalisacoor (strcat "Coordenada: " (rtos (car ptanalisa) 2 2) "," (rtos (cadr ptanalisa) 2 2) "		Descrição: " duvida))
	
	(command "_.layer" "m" "Geolayer-Duvidas" "")
    (command "text" ptanalisa "0" duvida)
		(command "_.layer" "s" "0" "")

(princ ptanalisacoor)
(princ)
)


(defun c:du3 ( / ptanalisa ptanalisacoor fil)

   (setvar "cmdecho" 0)

	(setq ptanalisa (getpoint "\n...:Ponto de Analise:..."))

	(setq ptanalisacoor (strcat "Coordenada: " (rtos (car ptanalisa) 2 2) "," (rtos (cadr ptanalisa) 2 2)))

	    (setq fil (open "C:/#Temp/GEOLAYER-DUVIDAS.txt" "a"))
		    (princ ptanalisacoor fil)
			   (princ "\n" fil)
	    (close fil)

(princ)
)