(setvar "cmdecho" 0)
(setvar "cmddia" 0)
(setvar "insunits" 6)
(princ "\nUnidades Alteradas para Metros com Sucesso...")
(command "-style" "" "Calibri" "0.5" "1" "0" "" "")
(princ "\nEstilo STANDARD Alterada para CALIBRI com Sucesso...")
(command "-style" "Geolayer_Titulos" "Calibri" "1" "1" "0" "" "")
(princ "\nCriado Estilo GEOLAYER-TITULOS com CALIBRI, 0.7 com Sucesso...")
;(command "MAPCSASSIGN" "ETRS_1989_Portugal_TM06")
(setvar "cmddia" 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;eleva textos de cotas
(defun c:au ( / aumento ent n temp c c1 c2 c3 res2)
(prompt "\n... Selecione o texto a aumentar!")


   (setq ent (ssget (list (cons 0 "text"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 11 (entget temp))))
   (setq c1 (rtos (car c) 2 8))
   (setq c2 (rtos (cadr c) 2 8))
   (setq c3 (caddr c))
   
   (setq aumento (rtos (+ c3 1) 2 2))
   
   (alert aumento)
   
   (setq res2 (strcat c1 "," c2 "," aumento))

   ;(command "erase" ent "")
	(command "-layer" "m" "Geoalyer-TEMP" "")
	
   (command "_.text" res2 "0" aumento)
    )
   )



(defun C:0 ()
(load "C:\\#Trabalho\\#Lisp_2017\\###Autoload.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\Layouts.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\##B.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\COORDENADAS.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\GEOLAYER-Duvidas.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\#Teste.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\GEOLAYER-LAYER.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\GEOLAYER-TEXTOS.lsp")
(load "C:\\#Trabalho\\#Lisp_2017\\GEOLAYER-Marcos_Coordenadas.lsp")
)


;;;;Retira para txt info layer - nome - cor . linetype
(defun c:infolay (/ sel entity name layer layerinf layerltype layercor layeresp infolayergeo lay_alst)
(prompt "\n...LAYER OBTER INFORMAÇÕES")
(setq sel (ssget ":S"))
(setq entity (ssname sel 0))
(setq name (entget entity))
(setq layer (cdr (assoc 8 name)))
(setq layerinf (tblsearch "LAYER" layer))
(setq layerltype (cdr (assoc 6 layerinf)))
(setq layercor (cdr (assoc 62 layerinf)))

(setq layertsca (cdr (assoc 49 layerinf)))
(alert layertsca)


(setq lay_alst (entget (tblobjname "LAYER" layer)))
(setq layeresp (cdr (assoc 370 lay_alst)))

(setq infolayergeo (strcat "\nLAYER: " layer "\nLINHA: " layerltype "\nCOR: " (rtos layercor 2 0) "\n	ESPESSURA: " (rtos (/ layeresp 100.0) 2 2) ))
(alert infolayergeo)
)


;Inicio de comando PPARCELARES, declaração de variaveis
;Para calcular a escala, deve-se dividir o valor inteiro por 1000
(defun c:layz (/ escala zoomclay)
(setvar "cmdecho" 1)
(setvar "osmode" 64)
;coloca a parcela no layout 0.5 =1/2000
;(setq escala (getreal (strcat "\n...escala 1:")))
(command "_.mspace")
(command "_.zoom" "e")
(setq zoomclay (getpoint "\nPonto de Centro .... "))
(command "_.zoom" "c" zoomclay "0.5XP")
(command "_.pspace")
;fim coloca a parcela no layout 0.5 =1/2000
)


(defun c:datad (/)
(setq d (rtos (getvar "cdate") 2 6)
          hrf (substr d 10 2)
           mf (substr d 12 2)
           sf (substr d 14 2)
          yrf (substr d 3 2)
          mof (substr d 5 2)
         dayf (substr d 7 2)
     );setq
	 
    (if (= mof "01") (setq mofv "janeiro"))	
    (if (= mof "02") (setq mofv "fevereiro"))		 
    (if (= mof "03") (setq mofv "março"))	
    (if (= mof "04") (setq mofv "abril"))	
    (if (= mof "05") (setq mofv "maio"))	
    (if (= mof "06") (setq mofv "junho"))	
    (if (= mof "07") (setq mofv "julho"))	
    (if (= mof "08") (setq mofv "agosto"))	
    (if (= mof "09") (setq mofv "setembro"))	
    (if (= mof "10") (setq mofv "outubro"))	
    (if (= mof "11") (setq mofv "novembro"))	
    (if (= mof "12") (setq mofv "dezembro"))	
	

     (setq texto_novo (strcat dayf " de " mofv " de 20" yrf))
	 (alert texto_novo)
 )
;+================================================+
;/////////////////////// $1$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
 (defun C:1 ()
   (setvar "cmdecho" 0)
   (COMMAND "pasteorig" "")
)
;+================================================+
;/////////////////////// $au$ \\\\\\\\\\\\\\\\\\\\\eleva textos de cotas
;+================================================+
(defun c:au ( / aumento ent n temp c c3orig c1 c2 c3 res2 sms)

(setvar "cmdecho" 0)
(setvar "osmode" 0)

(command "-style" "" "txt" "0.1" "1" "0" "" "" "")

(command "-layer" "n" "Geolayer-ERRO" "")

(prompt "\n... Selecione o texto a aumentar!")


   (setq ent (ssget (list (cons 0 "text"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 11 (entget temp))))
   (setq c1 (rtos (car c) 2 8))
   (setq c2 (rtos (cadr c) 2 8))
   (setq c3 (caddr c))
      (setq c3orig (rtos (caddr c) 2 2))
   
   (setq aumento (rtos (+ c3 1) 2 2))
   
   (setq res2 (strcat c1 "," c2 "," aumento))

   (command "_.change" temp "" "p" "la" "Geolayer-ERRO" "")
	(command "-layer" "m" "Geoalyer-TEMP" "")
	
   (command "_.text" res2 "0" aumento)
   
   (setq sms (strcat "\n....A cota " c3orig " passou a " aumento))
   (princ sms) (princ)
    )
   )
;+================================================+
;/////////////////////// $edbl$ \\\\\\\\\\\\\\\\\\\\\ EDITA BLOCOS
;+================================================+
(defun c:edbl (/ ss att ent txtread)
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

;+================================================+
;/////////////////////// $7$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:7 ()
   (setvar "cmdecho" 0)
   (command "purge" "all" "*" "n")
)
;+================================================+
;/////////////////////// $geolay$ \\\\\\\\\\\\\\\\\
;+================================================+
(defun c:geolay ()
(setvar "cmdecho" 0)
(setq nla (getstring "\n...Nome do Novo Layer: "))
;(setq nlacor (getstring "\n...Cor do Novo Layer: "))
(setq novolayer (strcat "Geolayer-" nla))
;(command "-layer" "n" novolayer "c" nlacor novolayer "f" novolayer "")
(command "-layer" "n" novolayer "f" novolayer "")
)
(defun c:clay ()
(setvar "cmdecho" 0)
(setq nla (getstring "\n...Nome do Novo Layer: "))
;(setq nlacor (getstring "\n...Cor do Novo Layer: "))
(setq novolayer (strcat "MERIDIAN_ZERO-" nla))
;(command "-layer" "n" novolayer "c" nlacor novolayer "f" novolayer "")
(command "-layer" "n" novolayer "f" novolayer "")
)
;+================================================+
;/////////////////////// $bi$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun C:bi ()

;Recolha e Modificação de Variáveis
(setvar "cmdecho" 0)
(setq PK1 (getvar "pickbox"))
(setvar "pickbox" 3)
(setq OM (getvar "osmode"))
(setvar "osmode" 32)
(setq AP1 (getvar "aperture"))
(setvar "aperture" 10)
(setq HILITE (getvar "highlight"))
(setvar "highlight" 1)
;Função de ERRO
  (setq OLDERR *error*)
  (defun *error* (errmes)
    (princ (strcat "\n..Erro Causado por: " ERRMES))
	(setvar "osmode" OM)
	(setvar "pickbox" PK1)
	(setvar "aperture" AP1)
	(setvar "highlight" HILITE)
	(setvar "cmdecho" 0)
    (setq *error* OLDERR)
    (prin1)
   )
;Função de Corte

(setq LN (entsel "\nEscolha o Elemento a Quebrar .... "))
(setvar "osmode" 32)
(setq BKPT (getpoint "\nPonto de Quebra .... "))
(if (/= bkpt nil)
(progn
(command "break" ln "f" BKPT "@")
(setvar "osmode" 0))
(progn
	(setvar "osmode" OM)
	(setvar "pickbox" PK1)
	(setvar "aperture" AP1)
	(setvar "highlight" HILITE)
	(setvar "cmdecho" 0) (exit))
)
;Restauro de Variáveis
(setvar "osmode" OM)
(setvar "pickbox" PK1)
(setvar "aperture" AP1)
(setvar "highlight" HILITE)
(setvar "cmdecho" 0)
(princ)
)
(princ)
;+================================================+
;/////////////////////// $lo$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:LO2 ()
  (setvar "cmdecho" 0)

  (setq alertsair (strcat "\....Comando desligado...."))
  
  (while
  (setq esc (entsel "\nDesligar Layer, Escolha o Elemento SF:"))
  (if (/= esc nil)
   (progn
  (setq poln (car    esc ))
  (setq pold (entget poln))
  (setq layr (cdr (assoc  8 pold)))
)

   (progn
     (princ alertsair)
        (princ)))

))

(defun c:lo (/ ent temp txtlay )

(setvar "cmdecho" 0)

(princ"\n...elementos a desligar:")
   (setq ent (ssget ))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq txtlay (cdr (assoc 8 (entget temp))))  ;8 para layer
 
 (command "layer" "set" "0" "")
  (command "layer" "off" txtlay "")
   
    )

(princ)
)
;+================================================+
;/////////////////////// $nor/cen$ \\\\\\\\\\\\\\\\\\\\\ normaliza layer e coloca centroids
;+================================================+
(defun c:nor ( / ent n temp txtlay entn continua total)
  (setvar "cmdecho" 0)
   (setvar "cmdecho" 0)
      (setvar "osmode" 0)
   (setq ent (ssget ":S"))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))
   (setq txtlay (cdr (assoc 8 (entget temp))))  ;8 para layer
   
   (setq entn (ssget "x" (list (cons 8 txtlay))))
   (setq total (sslength entn))
   
      (setq continua (getstring (strcat "\n...Encontramos " (rtos total 2 0) " elementos, continuamos? ENTER para continuar, N para terminar."))) 
       (if (= continua "n")(ABORT))		 
		   (command "pedit" "m" entn "" "join" "" "")
  (command "_.MATCHPROP" ent entn "")
  
  		 (print (strcat "...Encontramos " (rtos total 2 0) " no layer " txtlay))
		 (princ)
   )
   
   
(defun c:cen ( / ent n temp txtlay entn continua total)
   (setvar "cmdecho" 0)
      (setvar "osmode" 0)
   (setq ent (ssget ":S" (list (cons 0 "insert"))))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))
   (setq blockname (cdr (assoc 2 (entget temp))))  ;2 nome do bloco
   (setq txtlay (cdr (assoc 8 (entget temp))))  ;8 para layer
   
   (setq entn (ssget "x" (list (cons 8 txtlay))))
   (setq total (sslength entn))
   
      (setq continua (getstring (strcat "\n...Encontramos " (rtos total 2 0) " elementos, continuamos? ENTER para continuar, N para terminar."))) 
       (if (= continua "n")(ABORT))	
	   
	   		   (command "pedit" "m" entn "" "join" "" "")
  (command "_.MATCHPROP" ent entn "")
   
         (command "-mapcreatecentroids" "s" entn "" "o" txtlay blockname "") 
		 
		 (print (strcat "...Encontramos " (rtos total 2 0) " no layer " txtlay))
		 		 (princ)
   )
   
;+================================================+
;/////////////////////// $is$ \\\\\\\\\\\\\\\\\\\\\Seleciona elementos do mesmo layer
;+================================================+
(defun c:qwe (/ ent n temp elemsel ent01)

(prompt "\n...LAYER A SELECIONAR TODOS - ESCOLHA UM ELEMENTO")
   (setq ent (ssget ":S"))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))

   (setq elemsel (cdr (assoc 8 (entget temp))))
      
     (setq ent01 (ssget "x" (list (cons 8 elemsel))))
    (setq total (sslength ent01))
	
			 (print (strcat "...Encontramos " (rtos total 2 0) "elementos  no layer " elemsel))
		 		 (princ)
	
(command "pselect"  ent01 "")

)
;+================================================+
;/////////////////////// $is$ \\\\\\\\\\\\\\\\\\\\\Fecha elementos selecionadas close
;+================================================+
(defun c:ewq (/ ent n temp elemsel ent01)

(prompt "\n...FECHA TODOS OS ELEMENTOS ABERTOS - ESCOLHA UM ELEMENTO")
   (setq ent (ssget ":S"))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))

   (setq elemsel (cdr (assoc 8 (entget temp))))
   
   
     (setq ent01 (ssget "x" (list (cons 8 elemsel))))
  (command "pedit" "m" ent01 "" "join" "" "")
(command "_.pedit" "m" ent01 "" "c" "")

)
;+================================================+
;/////////////////////// $is$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:is ()
  (setvar "cmdecho" 1)
  (setq esc  (entsel "\nESCOLHA A ENTIDADE QUE QUER ISOLAR:"))
  (setq poln (car    esc ))
  (setq pold (entget poln))
  (setq layr (cdr (assoc  8 pold)))
  (command "layer" "set" layr "")
  (command "layer" "f" "*" "" "") 
  (command "layer" "t" "0" "set" "0" "")
  (setq mens001 (strcat "\nLAYER ISOLADO: " layr ))
)


(defun c:is0 ()
  (command "layer" "set" "0" "")
  (command "layer" "f" "*" "" "") 
)
;+================================================+
;/////////////////////// $il$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:il ()
  (setvar "cmdecho" 0)
  (setq esc  (entsel "\nESCOLHA A ENTIDADE QUE QUER MODOFICAR:"))
  (setq poln (car    esc ))
  (setq pold (entget poln))
  (setq layr (cdr (assoc  8 pold)))
  (command "layer" "set" layr "")
  (command "layer" "LO" "*" "U" layr "" "") 
  (command "pedit" "m" "all" "" "join" "" "")
  (command "layer" "U" "*" "" "") 
)
;+================================================+
;/////////////////////// $18$ \\\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:00(/)
  (setvar "cmdecho" 0)
  (command "layer" "set" "0" "")
  (command "layer" "u" "*" "")
  (command "layer" "t" "*" "")
  (command "layer" "on" "*" "")
)

;+================================================+
;//////////////////////// $or$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:or ()
(command "change" "all" "" "p" "c" "bylayer" "lt" "bylayer" "lw" "bylayer" "")
)
(defun c:or1 ()
(command "change" "all" "" "p" "c" "bylayer" "lt" "bylayer" "lw" "bylayer" "la" "0" "")
(command "bsave") (command "bclose")
)
;+================================================+
;+================================================+
(defun C:pcot (/ cortxtpoint pointcor)
;;;;

(setvar "osmode" 0)
  (setq nomefilecor (getstring "\nNome do Ficheiro de Coordenadas a Ler: "))

  (setq infcor (open (findfile (strcat nomefilecor ".txt")) "r"))


   (while (setq pointcor (read-line infcor))
	(command "_.point" pointcor)
   (setq ent (ssget "l" (list (cons 0 "point"))))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))

   (setq c3 (rtos (caddr c) 2 2))

    (command "text" pointcor "0" c3) 

  )
  (close infcor)
   
  (princ)
)

(defun C:pcot2 (/ cortxtpoint)
;;;;

(setvar "osmode" 0)
  (setq nomefilecor (getstring "\nNome do Ficheiro de Coordenadas a Ler: "))
  (setq nomefiletxt (getstring "\nNome do Ficheiro de Textos a Ler: "))
  (setq nomefilelay (getstring "\nNome do Ficheiro de Layer's a Ler: "))

  (setq inflay (open (findfile (strcat nomefilelay ".txt")) "r"))
  (setq infcor (open (findfile (strcat nomefilecor ".txt")) "r"))
  (setq inftxt (open (findfile (strcat nomefiletxt ".txt")) "r"))

   (while (setq pointcor (read-line infcor))
          (setq pointtxt (read-line inftxt))
          (setq pointlay (read-line inflay))

    (command "layer" "M" pointlay "")

    (command "_.point" pointcor)

    ;(command "text" pointcor "0" (strcat pointtxt )) 
    (command "text" pointcor "0" pointtxt)

  )
  (close inf)
   
  (princ)
)


(defun C:pcot3 (/ cortxtpoint)
;;;;
  (setq nomefilecor (getstring "\nNome do Ficheiro de Coordenadas a Ler: "))

  (setq infcor (open (findfile (strcat nomefilecor ".txt")) "r"))

   (while (setq pointcor (read-line infcor))

   ; (command "layer" "M" pointlay "")
    (COMMAND "-INSERT" "ARVORE" pointcor "" "" "")
   ; (command "_.point" pointcor)
    ;(command "_.-insert" "vertice" pointcor "" "" "")
    ;(command "text" pointcor "0" pointtxt) 
    ;(command "text" pointcor "0" pointtxt)

  )
  (close inf)
   
  (princ)
)

(defun C:PCOT4 (/ cortxtpoint nomefilecor nomefiletxt infcor)

  (setq nomefilecor (getstring "\nNome do Ficheiro de Coordenadas a Ler: "))
   (setq nomefiletxt (getstring "\nNome do Layer: "))

   (setq infcor (open (findfile (strcat nomefilecor ".txt")) "r"))

   (command "layer" "M" nomefiletxt "")
   
   (while (setq pointcor (read-line infcor))
    (command "_.point" pointcor)
  )
  (close inf)
   
  (princ)
)
;+================================================+
;////////////////////// $txtcoor$ \\\\\\\\\\\\\\\\\
;+================================================+
(defun c:txtcoor ( / ent file temp c txtread txtlay res2)
   ;(setq filenamez (getstring "\nNome do Ficheiro: "))
   ;(setq file (open (strcat "C:\#Temp\" filenamez ".txt") "a"))

  (setq filen
    (getfiled "Type or Select Text File Name" "" "txt" 1)
  )
   (setq file (open filen "a"))
    ;(setq ent (ssget (list (cons 0 "text"))))
   (setq ent (ssget (list (cons 0 "point"))))
   ;(setq ent (ssget (list (cons 0 "insert"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq txtread (cdr (assoc 1 (entget temp))))
   (setq txtlay (cdr (assoc 8 (entget temp))))  ;8 para layer
   (setq c1 (rtos (car c) 2 3))
   (setq c2 (rtos (cadr c) 2 3))
   (setq c3 (rtos (caddr c) 2 3))
   (setq res2 (strcat c1 ";" c2 ";" c3))
    ; (setq res2 (strcat c1 ";" c2 ";" txtread))
   ;(setq res2 (strcat txtlay  ";" txtread ";" c1 ";" c2 ";" c3))
   ;(setq res2 (strcat c1 "," c2))
   ;(setq res2 (strcat txtlay  ";" c1 ";" c2 ";" c3))
   (princ res2 file)
   (princ "\n" file)
    )
   (close file)
)
;+================================================+
;////////////////////// $zpt$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:zpt ( / res2 ent temp c c1 c2 c3 )
(setvar "osmode" 0)
   ;(setq ent (ssget (list (cons 0 "point"))))
   (setq ent (ssget (list (cons 0 "text"))))
   ;(setq ent (ssget (list (cons 0 "Circle"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq tt (cdr (assoc 1 (entget temp))))
   (setq c1 (rtos (car c) 2 8))
   (setq c2 (rtos (cadr c) 2 8))
   (setq c3 (rtos (caddr c) 2 2))
   (setq res2 (strcat c1 "," c2 "," c3))
   ;(setq res2 (strcat c1 "," c2 "," tt))
(command "-layer" "m" "Geolayer-Cota_Pt" "")
   (command "_.point" res2)
(command "_.-layer" "m" "Geolayer-Cota_Txt" "")
  (command "text" res2 "0" (strcat c3 ))
(command "-layer" "s" "0" "")
    )

)

(defun c:zpt1 ( / res2 ent temp c c1 c2 c3 )
(setvar "osmode" 0)
   (setq ent (ssget (list (cons 0 "text"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq tt (cdr (assoc 1 (entget temp))))

	(command "change" temp "" "p" "e" tt "")
    )
)


(defun c:zpt2 ( / res2 ent temp c c1 c2 c3 )
(setvar "osmode" 0)

(setq addic (getreal "\n...adicionar:"))
   (setq ent (ssget (list (cons 0 "text,point"))))
   ;(setq ent (ssget (list (cons 0 "Circle"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq tt (cdr (assoc 1 (entget temp))))
   (setq c1 (rtos (car c) 2 8))
   (setq c2 (rtos (cadr c) 2 8))
   (setq c3 (+ (caddr c) addic))
   
      (setq c33 (rtos c3 2 2))
   
  
   (setq res2 (strcat c1 "," c2))
   ;(setq res2 (strcat c1 "," c2 "," tt))
(command "_.-layer" "m" "Geolayer-Cota_Txt" "")
   (command "text" res2 "0" (strcat c33 ))
(command "-layer" "s" "0" "")
    )

)

;+================================================+
;////////////////////// $rtb$ \\\\\\\\\\\\\\\\\\\\replace text for blocks
;+================================================+
(defun c:rtb ( / res2 ent temp c c1 c2 c3 )
(setvar "osmode" 0)
   (setq ent (ssget (list (cons 0 "text,point"))))
   ;(setq ent (ssget (list (cons 0 "Circle"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq tt (cdr (assoc 1 (entget temp))))
   (setq c1 (rtos (car c) 2 8))
   (setq c2 (rtos (cadr c) 2 8))
   (setq c3 (rtos (caddr c) 2 2))
   (setq res2 (strcat c1 "," c2 "," c3))

  (COMMAND "-INSERT" "JARDIM" res2 "" "" "")

    )
   (close file)
)
;+================================================+
;////////////////////// $xc$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:xc ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "bylayer" "")
)
(defun c:xc1 ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "1" "")
)
(defun c:xc2 ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "2" "")
)
(defun c:xc3 ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "3" "")
)
(defun c:xc4 ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "4" "")
)
(defun c:xc5 ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "5" "")
)
(defun c:xcv ()
(setvar "cmdecho" 0)

(setq object (ssget))
(command "_.chprop" object "" "c" "1" "")
)
;+================================================+
;////////////////////// $mo$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:mo ()
(setq object (ssget))
(command "_.move" object "" "0,0" "200000,300000" "")
)
;*************************************************************************************
(defun c:om ()
(setq object (ssget))
(command "_.move" object "" "200000,300000" "0,0" "")
)
;+================================================+
;////////////////////// $ucso$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:QSA ()
(setvar "cmdecho" 0)
(setvar "tilemode" 1)
(command "-xref" "d" "*")
(command "ucs" "world")
(command "plan" "world")
(command "zoom" "e")
(command "qsave")
(command "close")
)
;+================================================+
;////////////////////// $legenda$ \\\\\\\\\\\\\\\\\
;+================================================+
(defun c:leg (/)
(setvar "cmdecho" 0)
  (setq esc  (entsel "\n...Selecione o Elemento a recolher o layer:"))
  (setq poln (car esc ))
  (setq pold (entget poln))
  (setq LAYERTXT (cdr (assoc 8 pold)))
  
   
 (setq texto_novo LAYERTXT)
 (prompt "\n...Selecione o Elemento de texto a modificar")
 (setq ss (ssget (list (cons 0 "TEXT"))))
 (if ss (progn (setq qtd (sslength ss))
 (setq ctd 0)
 (repeat qtd (setq ename (ssname ss ctd))
 (setq ent (entget ename))
 (entmod (subst (cons 1 texto_novo) (assoc 1 ent) ent))
 (entupd ename)
 (setq ctd (1+ ctd)) ) )
 (progn (alert (strcat "\nNão foi encontrado nenhum texto igual a: " ss) ) ) )
     )
;+================================================+
;////////////////////// $join$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:j (/ ss1 entLine objType oldcmdecho oldpeditaccept fuzz okObjects n nn)
  
  (setq alertt (strcat "\nSe continuar assim vai ter muito trabalho, o ficheiro vai ser TODO UNIDO! \nPara sua segurança, o comando vai ser reiniciado!!!\n.......ATENÇÃO À SEGUNDA VEZ NÃO AVISO!!!"))
  
  (setq oldcmdecho (getvar "cmdecho"))
  (setq oldpeditaccept (getvar "PEDITACCEPT"))
  (setvar "cmdecho" 0)
  (setq A2k4 (>= (substr (getvar "ACADVER") 1 2) "16"))
  (if A2k4 (setvar "PEDITACCEPT" 0))
  (setq	okObjects '((-4 . "<OR")
		      (0 . "LINE") (0 . "ARC") (0 . "POLYLINE") (0 . "LWPOLYLINE")
		    (-4 . "OR>")
		   )
  )
  (princ "\nSelect object to join: ")
  (setq ss1 (ssget okObjects))

     (setq n (sslength ss1))
     (setq nn (rtos n 2 0))

  (if (= nn "1")
   (progn
     (alert alertt) (c:j))
   (progn 
  (setq fuzz 0)
  (if (= fuzz nil) (setq fuzz 0))
  (if (/= ss1 nil)
      (progn
	(setq objType (cdr (assoc 0 (entget (setq entLine (ssname ss1 0))))))
	(if (= (sslength ss1) 1) (setq ss1 (ssget "X" okObjects)))
	(if (member objType '("LINE" "ARC"))
	  (command "_.pedit" "_M" ss1 "" "_Y" "_J" fuzz "")
	  (command "_.pedit" "_M" ss1 "" "_J" fuzz "")
	)
      )
  )))
  (setvar "cmdecho" oldcmdecho)
  (if A2k4 (setvar "PEDITACCEPT" oldpeditaccept))
  (princ)
)
;+================================================+
;////////////////////// $are$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun C:are (/ a ss n du)
  (setq a 0
        du (getvar "dimunit")
        ss (ssget '((0 . "*POLYLINE"))))
  (if ss
    (progn
      (setq n (1- (sslength ss)))
      (while (>= n 0)
        (command "_.area" "_o" (ssname ss n))
        (setq a (+ a (getvar "area"))
              n (1- n)))

      (princ
        (strcat "A Área Total dos Objectos Seleccionados Foi "
                (if (or (= du 3)(= du 4)(= du 6))
;
;The following 2 lines translate the area to square inches and feet
;for users using US engineering or architectural units:
;
                  (strcat (rtos a 2 1) " square inches,\nor "
                          (rtos (/ a 144.0) 2 1) " square feet.")

;
;In the following line, change the word "units" to whatever units
;you are using - meters, millimeters, feet, etc.
;
                  (strcat (rtos a 2 0) " Metros Quadrados."))))
				  
	(prompt "\n....Ponto de Inserção")

      (command "text" (getpoint) "0" (strcat (rtos a 2 0) " m²"))			  
				  
				  
				  )

    (alert "\nNo Polylines selected!"))


  (princ)
)
(princ)


(defun c:aper (/ a ss n du)

   (setq olderr *error* *error* err)

(WHILE
  (setq a 0
        p 0
        du (getvar "dimunit")
        ss (ssget '((0 . "*POLYLINE"))))

  (if ss
    (progn
      (setq n (1- (sslength ss)))
      (while (>= n 0)
        (command "_.area" "_o" (ssname ss n))

        (setq p (+ p (getvar "perimeter"))
              n (1- n))

      (setq lrsper (strcat (if (or (= du 3)(= du 4)(= du 6))
         (strcat (rtos p 2 2) (rtos (/ p 144.0) 2 2))
              (strcat (rtos p 2 2))))))))

(prompt "\n....Ponto de Inserção")

(command "text" (getpoint) "0" lrsper " m²")

     ; (command "text" (getpoint) "0" (strcat (rtos p 2 4) " m²"))

;(alert luis)
  (princ)
))
(princ)
;+================================================+
;////////////////////// $ucs3$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:3 ( / pot1 pot2 pot3 ent1 ent2 n temp c cc c1 c11 c2 c22 res1 res2 ent3)
(setvar "cmdecho" 1)

(setq pot1 (getpoint "\n...Ponto Central: "))
(setq pot2 (getpoint pot1 "\n...Ponto em X: "))
(setq pot3 (getpoint pot1 "\n...Ponto em Y: "))

(command "_.ucs" "3" pot1 pot2 pot3)
(command "_.plan" "")

(command "_.zoom" "w" "0,0" "1658.8151,291.2187")

(command "_.pspace")

(princ)
)
;+================================================+
;////////////////////// $zx$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:zx1 (/ pt1 pt2 ent n temp c txtread)
(setvar "cmdecho" 0)
(setvar "osmode" 1)

(command "_.mspace")
(setq pt1 (getpoint "\n...:::Ponto de Início:::... >"))
(setq pt2 (getpoint "\n...:::Ponto de Fim:::... >"))
(command "_.zoom" "w" pt1 pt2)

(prompt "\n...NOME DE LAYOUT RECOLHER")
   (setq ent (ssget ":S" (list (cons 0 "text"))))
   (setq n (sslength ent))
   (setq temp (ssname ent (setq n (- n 1))))
   (setq c (cdr (assoc 10 (entget temp))))
   (setq txtread (cdr (assoc 1 (entget temp))))
   
   		(command "change" ent "" "p" "c" "174" "")

(command "_.pspace")

(command "-layout" "r" "" txtread) 
(princ)
)

(defun c:zx (/ pt1 pt2 ent n temp c txtread)
(setvar "cmdecho" 0)
(setvar "osmode" 1)

(command "_.mspace")
(setq pt1 (getpoint "\n...:::Ponto de Início:::... >"))
(setq pt2 (getpoint "\n...:::Ponto de Fim:::... >"))
(command "_.zoom" "w" pt1 pt2)


(command "_.pspace")

(princ)
)
;+================================================+
;////////////////////// $pn$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(defun c:vername (/ e i j m n p s x in)
  (if (and (setq s (ssget '((0 . "LWPOLYLINE"))))
	   (setq x (getstring "\nSpecify prefix <enter for none>: "))
	   )
    (repeat (setq i (sslength s))
      (setq e (ssname s (setq i (1- i)))
	    n (cdr (assoc 210 (entget e)))
	    m (vlax-curve-getendparam e)
	    j -1
      )
      (while (<= (setq j (1+ j)) m)
	(setq p (trans (vlax-curve-getpointatparam e j) 0 e))
	(entmakex
	  (list
	    (cons 0 "TEXT")
	    (cons 7 (getvar 'TEXTSTYLE))
	    (cons 40 (getvar 'TEXTSIZE))
	    (cons 10 p)
	    (cons 11 p)
	    (cons 72 1)
	    (cons 73 2)
	    (cons 1 (strcat x (itoa (1+ j))))
	    (cons 210 n)
	  )
	)
      )
    )
  )
  (princ)
)
;+================================================+
;////////////////////// $dir_ex$ \\\\\\\\\\\\\\\\\\\\ direção dos eixos em linhas escorrecia de linhas de agua sentido
;+================================================+
(defun C:dir_ex ( / ent pr sc xxx resx cordtop1 cordtop2 resprz resscz resmid mens01 mens02)

		  (setvar "angbase" 0)
		  		  (setvar "cmdecho" 1)
				  		  (setvar "osmode" 0)

   (setq ent (ssget (list (cons 0 "line"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))

   (setq pr (cdr (assoc 10 (entget temp)))) ;primeira coordenada
   (setq sc (cdr (assoc 11 (entget temp)))) ;Segunda coordenada

	(setq xxx ( / (+ (car pr) (car sc)) 2))
	(setq resx (strcat (rtos xxx 2 8)))
	
	(setq cordtop1 (strcat (rtos (car pr) 2 8) "," (rtos (cadr pr) 2 8)))
	(setq resprz (caddr pr))
	(princ cordtop1)

	(setq yyy ( / (+ (cadr pr) (cadr sc)) 2))
	(setq resy (strcat (rtos yyy 2 8)))
	
	(setq cordtop2 (strcat (rtos (car sc) 2 8) "," (rtos (cadr sc) 2 8)))
	(setq resscz (caddr sc))
	(princ cordtop2)
	
	(setq resmid (strcat resx "," resy))

	 (setvar "angbase" 0)
     (command "angbase" cordtop1 cordtop2)
		
	(if (> resprz resscz)
	
	(progn
		(setq mens01 (strcat ">"))
		(command "_.text" resmid "0" mens01)

		  (setvar "angbase" 0)
		  		;(alert "1")
		)
	
	(progn
	(setq mens02 (strcat "<"))
		(command "_.text" resmid "0" mens02)

				 (setvar "angbase" 0)
				  				;(alert "2")
		)	

     )
	)
   )
;+================================================+
;////////////////////// $dir_ex$ \\\\\\\\\\\\\\\\\\\\ cotas nas pontas da linhas
;+================================================+
(defun c:cotlinha ( / ent pr sc xxx resx cordtop1 cordtop2 resprz resscz resmid mens01 mens02)

		  (setvar "angbase" 0)
		  		  (setvar "cmdecho" 1)
				  		  (setvar "osmode" 0)

   (setq ent (ssget (list (cons 0 "line"))))
   (setq n (sslength ent))
   (repeat n
   (setq temp (ssname ent (setq n (- n 1))))

   (setq pr (cdr (assoc 10 (entget temp)))) ;primeira coordenada
   (setq sc (cdr (assoc 11 (entget temp)))) ;Segunda coordenada

	
	(setq cordtop1 (strcat (rtos (car pr) 2 8) "," (rtos (cadr pr) 2 8) "," (rtos (caddr pr) 2 8)))
	(setq resprz (rtos (caddr pr) 2 2))
	
	(command "_.text" cordtop1 "0" resprz)
	(command "_.point" cordtop1)
	
	(setq cordtop2 (strcat (rtos (car sc) 2 8) "," (rtos (cadr sc) 2 8) "," (rtos (caddr sc) 2 8)))
	(setq resprz1 (rtos (caddr sc) 2 2))
	
	(command "_.text" cordtop2 "0" resprz1)
	(command "_.point" cordtop2)
		
	     )
	)
	
;+================================================+
;////////////////////// $SEGS$ \\\\\\\\\\\\\\\\\\\\ circulos e arcos para polylinhas com vertices 
;+================================================+
 
(defun c:Segs ( / *error* _StartUndo _EndUndo acdoc ss j ) (vl-load-com)
 
(defun *error* ( msg ) (and acdoc (_EndUndo acdoc))
 
(or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
 
(princ (strcat "\n** Error: " msg " **")))
 
(princ)
 
)
 
(defun _StartUndo ( doc ) (_EndUndo doc)
 
(vla-StartUndoMark doc)
 
)
 
(defun _EndUndo ( doc )
 
(if (= 8 (logand 8 (getvar 'UNDOCTL)))
 
(vla-EndUndoMark doc)
 
)
 
)
 
(setq acdoc (vla-get-ActiveDocument (vlax-get-acad-object)) *segs (cond ( *segs ) ( 10 )))
 
(if
 
(and (setq ss (ssget "_:L" '((0 . "ARC,CIRCLE,LWPOLYLINE,SPLINE,LINE,ELLIPSE"))))
 
(progn (initget 6)
 
(setq *segs (cond ( (getint (strcat "\nSpecify Number of Segments <" (itoa *segs) "> : ")) ) ( *segs )))
 
)
 
)
 
(progn (_StartUndo acdoc)
 
(repeat (setq j (sslength ss))
 
(
 
(lambda ( e / k l i p )
 
(setq k (/ (vlax-curve-getDistatParam e (vlax-curve-getEndParam e)) (float *segs))
 
l (entget e)
 
i -1
 
)
 
(repeat (1+ *segs)
 
(setq p (cons (cons 10 (trans (vlax-curve-getPointatDist e (* (setq i (1+ i)) k)) 0 e)) p))
 
)
 
(if
 
(entmake
 
(append
 
(list
 
(cons 0 "LWPOLYLINE")
 
(cons 100 "AcDbEntity")
 
(cons 100 "AcDbPolyline")
 
(cons 90 (length p))
 
(cons 38 (last (car p)))
 
(cons 70 (if (vlax-curve-isClosed e) 1 0))
 
)
 
(apply 'append
 
(mapcar '(lambda ( a ) (if (assoc a l) (list (assoc a l)))) '(6 8 39 48 62 210))
 
)
 
p
 
)
 
)
 
(entdel e)
 
)
 
)
 
(ssname ss (setq j (1- j)))
 
)
 
)
 
(_EndUndo acdoc)
 
)
 
)
 
(princ)
 
)
;+================================================+
;////////////////////// $geo$ \\\\\\\\\\\\\\\\\\\\
;+================================================+
(princ "\nTodos os lisps Comuns foram carregados com sucesso!")
(princ "\nGeolayer - Estudos de Território, Lda.")
(princ "\n*Luis Simões Produções lrs*")
(princ)