;;;;; Nombres: Arturo Alonso Carbonero y Victor Junco Sánchez ;;;;;
;;;;; Grupo: 3ºA - A1 ;;;;;
;;;;; Práctica 4 - Tarea 1 ;;;;;

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

(deftemplate rama
      (field abreviatura)
      (field nombre_completo)
  )

  (deffacts Ramas_carrera
      (rama (abreviatura CSI) (nombre_completo "Computacion y Sistemas Inteligentes"))
      (rama (abreviatura IS) (nombre_completo "Ingenieria del Software"))
      (rama (abreviatura SI) (nombre_completo "Sistemas de Informacion"))
      (rama (abreviatura IC) (nombre_completo "Ingenieria de Computadores"))
      (rama (abreviatura TI) (nombre_completo "Tecnologias de la Informacion"))
  )

  (deffacts Ambito_preguntas
      (preguntas hardware)
      (preguntas sofwtare)
      (preguntas matematicas)
      (preguntas esfuerzo)
      (preguntas promedio)
  )

  (deftemplate Respuestas_factibles
      (field Nombre_pregunta)
      (multifield posible_respuesta)
  )

  (deffacts RellenarRespuestas
      (Respuestas_factibles (Nombre_pregunta hardware)
          (posible_respuesta "si" "no" "no se")
      )

      (Respuestas_factibles (Nombre_pregunta sofwtare)
          (posible_respuesta "si" "no" "no se ")
      )

      (Respuestas_factibles (Nombre_pregunta matematicas)
          (posible_respuesta "si" "no" "no se")
      )

      (Respuestas_factibles (Nombre_pregunta promedio)
          (posible_respuesta "alto" "medio" "bajo")
      )

      (Respuestas_factibles (Nombre_pregunta esfuerzo)
          (posible_respuesta "mucho" "medio" "poco")
      )
  )

  (deftemplate recomendacion
      (field Rama_Abrev)
      (multifield Gusta_Hardware)
      (multifield Gusta_Software)
      (multifield Gusta_Esfuerzo)
      (multifield NotaMedia)
      (multifield Gusta_Matematicas)
      (field motivo)
  )

  (deffacts Base_Recomendaciones
      (recomendacion (Rama_Abrev IC)
          (Gusta_Hardware "si"  "no se ")
          (Gusta_Software "no" " no se ")
          (Gusta_Esfuerzo  "mucho" "medio" "alto")
          (NotaMedia "alto" "medio" "bajo")
          (Gusta_Matematicas "si" "no" "no se ")
          (motivo "Esta es la rama asociada al Hardware como parece que te gusta creo que es la mejor recomendacion ")
      )

      (recomendacion (Rama_Abrev IS)
          (Gusta_Hardware "no" "no se")
          (Gusta_Software "si")
          (Gusta_Esfuerzo "mucho" "medio")
          (NotaMedia "medio" )
          (Gusta_Matematicas "si" "no se")
          (motivo "Esta es la rama asociada al Software como parece que te gusta sofwtare y tienes un buen promedio y te gusta trabajar sera perfecta para ti ")
      )


      (recomendacion (Rama_Abrev CSI)

          (Gusta_Hardware  "no" "no se")
          (Gusta_Software "si" "no se")
          (Gusta_Esfuerzo "mucho" "medio")
          (NotaMedia "medio" "alto")
          (Gusta_Matematicas "si" )
          (motivo "Esta es la rama asociada a la Inteligencia Artificial y  como te gustan las matematicas sueles trabajar bien y no tienes problema en sofwtare creo que es la mas adecuada para ti ")
      )


      (recomendacion (Rama_Abrev SI)
          (Gusta_Hardware "no" "me da igual")
          (Gusta_Software "si" "me da igual")
          (Gusta_Esfuerzo "medio")
          (NotaMedia  "medio" "bajo")
          (Gusta_Matematicas "no" "me da igual")
          (motivo "Quizas esta sea la rama mas asociada a la programacion por tanto como te gusta el sofwtare pero tienes un rendimiento medio y no te gustan las matematicas esto es lo mejor que te puedo recomendar")
      )

      (recomendacion (Rama_Abrev TI)
          (Gusta_Hardware "no" "me da igual")
          (Gusta_Software "no" "me da igual")
          (Gusta_Esfuerzo "poco" "medio")
          (NotaMedia "medio" "bajo")
          (Gusta_Matematicas "no" "me da igual")
          (motivo "En esta rama aprenderas a tratar datos e informacion de maneras unicas y es perfecta para aquellos que no quieren esforzarse demasiado o que no tienen muy buena nota")
      )
  )


(defrule inicio
    (declare (salience 9000))
        =>
    (printout t crlf "Comienza el Sistema encargado de dar una recomendacion sobre la eleccion de una rama en Ingenieria Informatica en la UGR " crlf)
    (printout t crlf "A continuacion se le haran una serie de preguntas responda de entre las posibles respuestas la que mas le represente " crlf)
    (printout t crlf "Las primeras preguntas correspondes al experto Arturo Alonso Carbonero" crlf)
    (assert (razonar))
    (assert (module BETA))
)


;;;;; - - - Reglas del sistema - - - ;;;;;

; Nota media
(defrule notamedia
  (declare (salience 5000)) ; Es lo primero que le preguntaría
  (module BETA)
  =>
  (printout t "Bienvenido, dime cual es tu nota media hasta ahora redondeando a la alta por favor: " crlf)
  (assert (Calificacion_media (read))) ; Obtenemos la nota media y podemos saber si es alta, media o baja
)

; Almacena la nota media y guarda un hecho para indicar si es baja, media o alta
(defrule almacenarNota
  (declare (salience 4999))
  (module BETA)
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
  (module BETA)
  =>
  (printout t "Te gustan las matematicas?" crlf)
  (assert (mates (read)))
)

; Interés por la programación
(defrule Iprogramacion
  (declare (salience 4999))
  (module BETA)
  =>
  (printout t "Tienes interes por la programacion?" crlf)
  (assert (programacion (read)))
)

; Si le gustan las matemáticas y tiene nota media alta o media
(defrule matesAlta
  (declare (salience 4800))
  (module BETA)
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
  (module BETA)
  (podriaSer Computacion_y_Sistemas_Inteligentes)
  =>
  (printout t "Te gustaria desarrollar algoritmos o algo similar?" crlf)
  (assert (algoritmos (read)))
)

; Si le gustan la algorítmica entonces podría ser CSI
(defrule puedeCSI
  (module BETA)
  (algoritmos si)
  =>
  (assert (podriaSer Computacion_y_Sistemas_Inteligentes))
)

; Hardware / Software
(defrule hardsoft
  (declare (salience 4000))
  (module BETA)
  =>
  (printout t "Prefieres software o hardware?" crlf)
  (assert (preferencia_sh (read)))
)

; Si tiene nota media o alta y le interesa la programación
(defrule matesAltMedProg
  (declare (salience 3999))
  (module BETA)
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
  (module BETA)
  (preferencia_sh hardware)
  (podriaSer Computacion_y_Sistemas_Inteligentes)
  =>
  (assert (podriaSer Ingenieria_de_Computadores))
  (printout t "Podria interesarte la rama de IC" crlf)
)

; Si le gusta el hardware y no las mates
(defrule puedeTI
  (declare (salience 3949))
  (module BETA)
  (preferencia_sh hardware)
  (mates no)
  =>
  (assert (podriaSer Tecnologias_de_la_Informacion))
  (printout t "Podria interesarte la rama de TI" crlf)
)

; Robótica
(defrule robotica
  (declare (salience 3950))
  (module BETA)
  (podriaSer Ingenieria_de_Computadores)
  =>
  (printout t "Te gusta la robotica?" crlf)
  (assert (robotica (read)))
)

; Prácticas / Teóricas
(defrule practheo
  (declare (salience 3900))
  (module BETA)
  =>
  (printout t "Prefieres asignaturas practicas o teoricas?" crlf)
  (assert (preferencia_tp (read)))
)

; Gusto por bases de datos
(defrule gustaBD
  (declare (salience -5002))
  (module BETA)
  (podriaSer Ingenieria_del_Software)
  (test (or (neq preferencia_tp teoricas) (neq preferencia_tp practicas)))
  =>
  (printout t "Te gustan las bases de datos?" crlf)
  (assert (gustaBD (read)))
)

; Deduce que podría ser Sistemas_de_Informacion si le gustan las bases de datos
(defrule puedeSI
  (module BETA)
  (gustaBD si)
  =>
  (assert (podriaSer Sistemas_de_Informacion))
)


;;;;; - - - Consejos - - - ;;;;;

; Establece el hecho 'consejo Ingenieria_de_Computadores'
(defrule consejo1
  (declare (salience -5000))
  ?regla <- (module BETA)
  (podriaSer Ingenieria_de_Computadores)
  (preferencia_tp practicas)
  (robotica si)
  =>
  (retract ?regla)
  (assert (module ALFA))
  (assert (consejo Ingenieria_de_Computadores))
)

; Establece el hecho 'consejo Computacion_y_Sistemas_Inteligentes'
(defrule consejo2
  (declare (salience -5001))
  ?regla <- (module BETA)
  (podriaSer Computacion_y_Sistemas_Inteligentes)
  (algoritmos si)
  =>
  (retract ?regla)
  (assert (module ALFA))
  (assert (consejo Computacion_y_Sistemas_Inteligentes))
)

; Establece el hecho 'consejo Ingenieria_del_Software'
(defrule consejo3
  (declare (salience -5002))
  ?regla <- (module BETA)
  (podriaSer Ingenieria_del_Software)
  =>
  (retract ?regla)
  (assert (module ALFA))
  (assert (consejo Ingenieria_del_Software))
)

; Establece el hecho 'consejo Sistemas_de_Informacion'
(defrule consejo4
  (declare (salience -5003))
  ?regla <- (module BETA)
  ?regla2 <- (consejo Ingenieria_del_Software)
  (podriaSer Sistemas_de_Informacion)
  =>
  (retract ?regla)
  (assert (module ALFA))
  (retract ?regla2)
  (assert (consejo Sistemas_de_Informacion))
)

; Establece el hecho 'consejo Tecnologias_de_la_Informacion'
(defrule consejo5
  (declare (salience -5004))
  ?regla <- (module BETA)
  (or (podriaSer Ingenieria_de_Computadores) (podriaSer Tecnologias_de_la_Informacion))
  (test (neq robotica si))
  =>
  (retract ?regla)
  (assert (module ALFA))
  (assert (consejo Tecnologias_de_la_Informacion))
)


(defrule PreguntaHardware
    (razonar)
    (module ALFA)
    ?rule <- (preguntas hardware)
        =>
    (retract ?rule)
    
    (printout t crlf "------------" crlf  "COMIENZAN LAS PREGUNTAS DEL EXPERTO VICTOR " crlf "----------" crlf)
    (printout t crlf " ***  ¿Te gusta el hardware? "  crlf " Las posibles respuestas son  [si , no , no se] " crlf )
    (assert(answer hardware (lowcase (readline))))
)

(defrule PreguntaSowftare
    (razonar)
     (module ALFA)
    ?rule <- (preguntas sofwtare)
        =>
    (retract ?rule)
    (printout t crlf " *** ¿Dirias que te gusta todo aquello relacionado con el sofwtare ? " crlf " Las posibles respuestas son  [si, no, no se] " crlf)
    (assert(answer sofwtare (lowcase (readline))))
)

(defrule PreguntaMatematicas
    (razonar)
    (module ALFA)
    ?rule <- (preguntas matematicas)
        =>
    (retract ?rule)
    (printout t crlf " *** ¿ Dirias que te gustan las matematicas?" crlf " Las posibles respuestas son [ si , no , no se] " crlf)
    (assert(answer matematicas (lowcase(readline))))
)
(defrule PreguntaNotaMedia
    (razonar)
    (module ALFA)
    ?rule <- (preguntas promedio)
        =>
    (retract ?rule)
    (printout t  crlf " **** ¿Como dirias que es tu nota media? " crlf " Si es mayor que 8 di alto. Si esta entre 6 y 8 di medio . Si es menor que 6 di bajo" crlf )
    (assert(answer promedio (lowcase(readline))))
)

(defrule PreguntaEsfuerzo
    (razonar)
    (module ALFA)
    ?rule <- (preguntas esfuerzo)
        =>
    (printout t crlf " *** ¿Cual suele ser tu nivel de esfuerzo para hacer una tarea?." crlf " Las posibles respuestas son  [ mucho, medio o poco ] " crlf )
    (assert(answer esfuerzo (lowcase(readline))))
    (assert (module GAMMA))
)


(defrule Recomienda
    (declare (salience 100))
    ?rule <- (razonar)
    (answer hardware ?a)
    (answer sofwtare ?b)
    (answer promedio ?c)
    (answer matematicas ?d)
    (answer esfuerzo ?e)
    (recomendacion (Rama_Abrev ?nombre_completo) (Gusta_Hardware $? ?a $?) (Gusta_Software $? ?b $?) (Gusta_Esfuerzo $? ?e $?) (NotaMedia $? ?c $?) (Gusta_Matematicas $? ?d $?) (motivo ?motiv))
    (rama (abreviatura ?nombre_completo) (nombre_completo ?NombreRama))
    (module ALFA)
        =>
    (retract ?rule)
    (assert(ans ?NombreRama ?motiv))
)


; Consejo Final
(defrule mostrarRamaFinal
  (declare (salience -9999))
  (consejo ?r)
  (module GAMMA)
  =>
  (printout t "Arturo te recomienda  la rama de " ?r crlf)

)

(defrule MostrarRecomendacion
  (declare (salience -9999))

    (ans ?NombreRama ?motiv)
     (consejo ?r)
     (module GAMMA)
        =>
    (printout t crlf "La rama que se te recomienda el experto Victor es  " ?NombreRama "." crlf " " ?motiv "." crlf)

)

(defrule NoTengoRespuesta
    (declare (salience -9999))

    (answer hardware ? )
    (answer sofwtare ? )
    (answer matematicas ?)
    (answer promedio?|esfuerzo ? )
    (module GAMMA)
    ?rule <- (razonar)
        =>
    (printout t crlf "El experto Victor no ha podido recomendarte nada en base a tus respuestas" crlf)
    (retract ?rule)
)
