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
    ; Añadir teóricas/prácticas
    ; Añadir por programación
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
    (declare (salience 100))
        =>
    (printout t crlf "Comienza el Sistema encargado de dar una recomendacion sobre la eleccion de una rama en Ingenieria Informatica en la UGR " crlf)
    (printout t crlf "A continuacion se le haran una serie de preguntas responda de entre las posibles respuestas la que mas le represente " crlf)
    (assert (razonar))
)
(defrule PreguntaHardware
    (razonar)
    ?rule <- (preguntas hardware)
        =>
    (retract ?rule)
    (printout t crlf " ***  ¿Te gusta el hardware? "  crlf " Las posibles respuestas son  [si , no , no se] " crlf )
    (assert(answer hardware (lowcase (readline))))
)

(defrule PreguntaSowftare
    (razonar)
    ?rule <- (preguntas sofwtare)
        =>
    (retract ?rule)
    (printout t crlf " *** ¿Dirias que te gusta todo aquello relacionado con el sofwtare ? " crlf " Las posibles respuestas son  [si, no, no se] " crlf)
    (assert(answer sofwtare (lowcase (readline))))
)

(defrule PreguntaMatematicas
    (razonar)
    ?rule <- (preguntas matematicas)
        =>
    (retract ?rule)
    (printout t crlf " *** ¿ Dirias que te gustan las matematicas?" crlf " Las posibles respuestas son [ si , no , no se] " crlf)
    (assert(answer matematicas (lowcase(readline))))
)
(defrule PreguntaNotaMedia
    (razonar)
    ?rule <- (preguntas promedio)
        =>
    (retract ?rule)
    (printout t  crlf " **** ¿Como dirias que es tu nota media? " crlf " Si es mayor que 8 di alto. Si esta entre 6 y 8 di medio . Si es menor que 6 di bajo" crlf )
    (assert(answer promedio (lowcase(readline))))
)

(defrule PreguntaEsfuerzo
    (razonar)
    ?rule <- (preguntas esfuerzo)
        =>
    (printout t crlf " *** ¿Cual suele ser tu nivel de esfuerzo para hacer una tarea?." crlf " Las posibles respuestas son  [ mucho, medio o poco ] " crlf )
    (assert(answer esfuerzo (lowcase(readline))))
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
        =>
    (retract ?rule)
    (assert (ans ?NombreRama ?motiv))
)

(defrule MostrarRecomendacion
    (ans ?NombreRama ?motiv)
        =>
    (printout t crlf "La rama que se te recomienda es  " ?NombreRama "." crlf " " ?motiv "." crlf)
    (printout t crlf "Recuerda que esto es solo una recomendacion, lo mejor es que si no estas conforme vuelvas a repetir el programa cambiando un poco los datos o investigues por tu cuenta las ramas " crlf)
)

(defrule NoTengoRespuesta
    (declare (salience -10))
    
    (answer hardware ? )
    (answer sofwtare ? )
    (answer matematicas ?)
    (answer promedio?|esfuerzo ? )

    ?rule <- (razonar)
        =>
    (printout t crlf "Con las respuestas que me has dado no puedo recomendarte nada con seguridad te aconsejo que vuelvas a probar pensando un poco mejor las respuestas" crlf)
    (retract ?rule)
)
