;;;;; Nombre: Arturo Alonso Carbonero ;;;;;
;;;;; Grupo: 3ºA - A1 ;;;;;
;;;;; Práctica 3 - Sistema experto simple ;;;;;

;;;;; - - - Propiedades - - - ;;;;;
;
; Nota media: (Calificacion_media Alta|Media|Baja)
; Se deducirá de la nota media solicitada al usuario: (Calificacion_media ?c)
;
; Gusto por las matemáticas: (Gusto_mates Si|No|Nose)
; Se deducirá del gusto solicitado al usuario: (Mates ?Gm)
;
; Preferencia por software/hardware: (Preferencia_sh Hardware|Software|Nose)
; Se deducirá de la preferencia solicitada al usuario: (Preferenca_sh ?Psh)
;
; Interés por la programación: (Interes_programacion Mucho|Ninguno|Nose)
; Se deducirá del interés solicitado al usuario: (Programacion ?Ip)
;
; Preferencia por teoría/prácticas: (Preferencia_tp Teoria|Practicas|Nose)
; Se deducirá de la preferencia solicitada al usuario: (Preferencia_tp ?Ptp)

; (Ir sumando pesos según la respuesta y asignar un peso a cada rama) ???

; Inferir antes de preguntar
; Que una pregunta tenga ocmo antecedente haber preguntado otra (preguntar por)


; Realizará ciertas preguntas en función de las respuestas qeu obtenga a otras preguntas
; Es decir, tras las preguntas básicas indicadas anteriormente, utilizará las respuestas
; obteneidas como antecedentes para preguntar cuestiones más concretas.


;;;;; - - - Hechos del sistema - - - ;;;;;


; Representación de las ramas
(deffacts Ramas
  (Rama Computacion_y_Sistemas_Inteligentes)
  (Rama Ingenieria_del_Software)
  (Rama Ingenieria_de_Computadores)
  (Rama Sistemas_de_Informacion)
  (Rama Tecnologias_de_la_Informacion)
)

; Nota media
(deffacts Notam
  ;;;; (Nota 10 Alta)
  (Nota 7 10.1 Alta) ; 7 > x > 10

  ;;;; (Nota 6.9 Media)
  (Nota 5.5 6.9 Media) ; 5.5 > x > 6.9

  ;;;; (Nota 5.4 Baja)
  (Nota 1 5.4 Baja) ; 1 > x > 5.4
)

;;;;; - - - Reglas del sistema - - - ;;;;;

; Nota media
(defrule notamedia
  (declare (salience 5000)) ; Es lo primero que le preguntaría
  =>
  (printout t "Bienvenido, dime cual es tu nota media hasta ahora redondeando a la alta por favor: " crlf)
  (assert (Calificacion_media (read))) ; Obtenemos la nota media y podemos saber si es alta, media o baja
)

; Almacena la nota media y guarda un hecho para indicar si es baja, media o alta
(defrule almacenarNota
  (declare (salience 4999))
  (Calificacion_media ?n)
  (Nota ?x ?y ?val)
  (test (> ?n ?x))
  (test (< ?n ?y))
  =>
  (assert (notaEs ?val))
)

; Matemáticas
(defrule mates
  (declare (salience 4995))
  =>
  (printout t "Te gustan las matematicas?" crlf)
  (assert (mates (read)))
)

; Interés por la programación
(defrule Iprogramacion
  (declare (salience 4999))
  =>
  (printout t "Tienes interes por la programacion?" crlf)
  (assert (programacion (read)))
)

; Si le gustan las matemáticas y tiene nota media alta o media
(defrule matesAlta
  (declare (salience 4800))
  (test (neq notaEs Baja)) ; Media o alta
  (mates si)
  (programacion si)
  =>
  (assert (podriaSer Computacion_y_Sistemas_Inteligentes))
  (printout t "De momento creo que podrias optar por la rama de CSI" crlf)
)

; Pregunta en relación a la algorítmica
(defrule algoritmos
  (declare (salience 4799))
  (podriaSer Computacion_y_Sistemas_Inteligentes)
  =>
  (printout t "Te gustaria desarrollar algoritmos o algo similar?" crlf)
  (assert (algoritmos (read)))
)

; Si le gustan la algorítmica entonces podría ser CSI
(defrule puedeCSI
  (algoritmos si)
  =>
  (assert (podriaSer Computacion_y_Sistemas_Inteligentes))
)

; Hardware / Software
(defrule hardsoft
  (declare (salience 4000))
  =>
  (printout t "Prefieres software o hardware?" crlf)
  (assert (preferencia_sh (read)))
)

; Si tiene nota media o alta y le interesa la programación
(defrule matesAltMedProg
  (declare (salience 3999))
  (test (neq notaEs Baja)) ; Media o alta
  (programacion si)
  (preferencia_sh software)
  =>
  (assert (podriaSer Ingenieria_del_Software))
  (printout t "Podria gustarte la rama de IS" crlf)
)

; Si le gustan las mates, la programacion y prefiere hardware
(defrule csiHard
  (declare (salience 3950))
  (preferencia_sh hardware)
  (podriaSer Computacion_y_Sistemas_Inteligentes)
  =>
  (assert (podriaSer Ingenieria_de_Computadores))
  (printout t "Podria interesarte la rama de IC" crlf)
)

; Si le gusta el hardware y no las mates
(defrule puedeTI
  (declare (salience 3949))
  (preferencia_sh hardware)
  (mates no)
  =>
  (assert (podriaSer Tecnologias_de_la_Informacion))
  (printout t "Podria interesarte la rama de TI" crlf)
)

; Robótica
(defrule robotica
  (declare (salience 3950))
  (podriaSer Ingenieria_de_Computadores)
  =>
  (printout t "Te gusta la robotica?" crlf)
  (assert (robotica (read)))
)

; Prácticas / Teóricas
(defrule practheo
  (declare (salience 3900))
  =>
  (printout t "Prefieres asignaturas practicas o teoricas?" crlf)
  (assert (preferencia_tp (read)))
)

; Gusto por bases de datos
(defrule gustaBD
  (declare (salience -5002))
  (podriaSer Ingenieria_del_Software)
  (test (or (neq preferencia_tp teoricas) (neq preferencia_tp practicas)))
  =>
  (printout t "Te gustan las bases de datos?" crlf)
  (assert (gustaBD (read)))
)

; Deduce que podría ser Sistemas_de_Informacion si le gustan las bases de datos
(defrule puedeSI
  (gustaBD si)
  =>
  (assert (podriaSer Sistemas_de_Informacion))
)


;;;;; - - - Consejos - - - ;;;;;

; Establece el hecho 'consejo Ingenieria_de_Computadores'
(defrule consejo1
  (declare (salience -5000))
  (podriaSer Ingenieria_de_Computadores)
  (preferencia_tp practicas)
  (robotica si)
  =>
  (assert (consejo Ingenieria_de_Computadores))
)

; Establece el hecho 'consejo Computacion_y_Sistemas_Inteligentes'
(defrule consejo2
  (declare (salience -5001))
  (podriaSer Computacion_y_Sistemas_Inteligentes)
  (algoritmos si)
  =>
  (assert (consejo Computacion_y_Sistemas_Inteligentes))
)

; Establece el hecho 'consejo Ingenieria_del_Software'
(defrule consejo3
  (declare (salience -5002))
  (podriaSer Ingenieria_del_Software)
  (preferencia_tp practicas)
  =>
  (assert (consejo Ingenieria_del_Software))
)

; Establece el hecho 'consejo Sistemas_de_Informacion'
(defrule consejo4
  (declare (salience -5003))
  (podriaSer Sistemas_de_Informacion)
  =>
  (assert (consejo Sistemas_de_Informacion))
)

; Establece el hecho 'consejo Tecnologias_de_la_Informacion'
(defrule consejo5
  (declare (salience -5004))
  (or (podriaSer Ingenieria_de_Computadores) (podriaSer Tecnologias_de_la_Informacion))
  (test (neq robotica si))
  =>
  (assert (consejo Tecnologias_de_la_Informacion))
)


; Consejo Final
(defrule mostrarRamaFinal
  (declare (salience -9999))
  (consejo ?r)
  =>
  (printout t "Te recomiendo la rama de " ?r crlf)
)
