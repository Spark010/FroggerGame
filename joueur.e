note
	description: "Classe joueur, définie les spécificité du joueur."
	author: "Francis Croteau"
	date: "2020-02-17"
	revision: "$Revision$"

class
	JOUEUR


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			--assignation des attributs par 'défault'
			nom:="Frogger"
			vie:=3
			x:=0
			y:=0

		end

feature --Acces
	vie:INTEGER
	nom:STRING --nom du joueur
	x:INTEGER_32
		--position vertical de `Current'

	y:INTEGER_32
		--position horizontal de `Current'

	bouger_haut
		--on bouge en hautr
		do
	   		--ixi
		end

	bouger_bas
		do
	    	--ici
		end

	bouger_droite
		do
	    	--tada
		end

	bouger_gauche
		do
	    	--data
		end
end
