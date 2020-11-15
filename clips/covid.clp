
;;;======================================================
;;;   VERY SMALL COVID Expert System
;;;
;;;     This expert system diagnoses on COVID
;;;
;;;     ;;;
;;;   To execute, merely load, reset and run.
; (load covid.clp)
; (reset)
; (run)
; REPEAT THE CYCLE: (load covid.clp) (reset) (run) for a new query 
; (rules) show rules
; (facts) show facts
; (agenda) ... rules to triggered
;;;======================================================

;;****************
;;* DEFFUNCTIONS *
;;****************

(deffunction f_ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (read))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (read))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction f_yes-or-no (?question)
   (bind ?response (f_ask-question ?question yes no y n))
   (if (or (eq ?response yes) (eq ?response y))
       then yes 
       else no))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determine-fever ""
   (not (pain-in-body ?))
   (not (no-conclusion ?))
   =>
   (assert (has-fever (f_yes-or-no "Do you present fever (yes/y/no/n)? "))))
   
(defrule determine-pain-in-body ""
   (has-fever yes)
   (not (no-conclusion ?))
   =>
   (assert (pain-in-body (f_yes-or-no "Do you present some paint in the body
   (yes/y/no/n)? "))))



(defrule determine-receive-exam ""
   (has-fever yes)
   (pain-in-body yes)
   (not (no-conclusion ?))
   =>
   (assert (already_confirmed (f_yes-or-no "Did you receive you exam?)
   (yes/y/no/n)? "))))


;;;****************
;;;* REPAIR or ORIENTATION RULES *
;;;****************

(defrule covid-conclusion_01 ""
   (has-fever yes)
   (pain-in-body yes)
   (not (no-conclusion ?))
   =>
   (assert (conclusion "Please, search urgently a doctor.")))


(defrule covid-conclusion_03 ""
   (not (has-fever no))
   (pain-in-body no)
   (not (no-conclusion ?))
   =>
   (assert (not-conclusion " Missing clinical evidences.")))


(defrule covid-conclusion_02 ""
   (has-fever no)
   (not (pain-in-body no))
   (not (no-conclusion ?))
   =>
   (assert (not-conclusion " Missing clinical evidences.")))


(defrule receiving-exam ""
  (declare (salience -10))
  (already_confirmed yes)
  (has-fever yes)
  (pain-in-body yes)
  (not (conclusion ?))
  =>
  (assert (conclusion "Please, follow the protocols for COVID")))

;;; (declare (salience -10))
  
(defrule no-conclusion_01 ""
  (already_confirmed yes)
  (has-fever yes)
  (pain-in-body yes)
  (not (conclusion ?))
  =>
  (assert (no-conclusion "Take your medicaments under doctor orientation.")))

;;;********************************
;;;* STARTUP AND CONCLUSION RULES *
;;;********************************

(defrule system-banner ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "The Small Diagnosis Expert System")
  (printout t crlf "COVID 19")
  (printout t crlf crlf))

(defrule print-orientation ""
  (declare (salience 10))
  (conclusion ?item)    ;;;; where is conclusion arrive something
  =>
  (printout t crlf crlf)
  (printout t "Medical Suggestion or Conduction:")
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item))


