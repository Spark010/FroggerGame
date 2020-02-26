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
	vie:INTEGER
	nom:STRING --nom du joueur
	x:INTEGER_32--position vertical de `Current'
	x_min:INTEGER_32
	x_max:INTEGER_32
	x_width:INTEGER_32
	y:INTEGER_32 --position horizontal de `Current'
	y_min:INTEGER_32
	y_max:INTEGER_32
	y_width:INTEGER_32

	make
			-- Initialization for `Current'.
		do
			--assignation des attributs par 'défault'
			nom:="Frogger"
			vie:=3
			--sur l'axe des x
			x_max := 240
			x_min := 0
			x_width:=12
			--sur l'axe des y
			y_max := 200
			y_min := 80
			y_width:=10
			placer_origine


		end

feature --Acces



	bouger_haut
		--on bouge en hautr
		do
	   		y:= y+10
	   		if y > y_max then
	   			y:=y_max
	   		end
		end

	bouger_bas
		--on bouge en bas
		do
			y:= y-10
	   		if y < y_min then
	   			y:=y_min
	   		end
	    	--ici
		end

	bouger_droite
		--on bouge a droite
		do
	    	x:= x+10
	   		if y > x_max then
	   			x:=x_max
	   		end
		end

	bouger_gauche
		--on bouge a gauche
		do
	    	x:= x-10
	   		if x < x_min then
	   			x:=x_min
	   		end
		end

feature --Getters

	get_x:INTEGER_32
		do
		    RESULT:=x
		end

	get_y:INTEGER_32
		do
		    RESULT:=y
		end

	get_x_width:INTEGER_32
		do
		    RESULT:=x_width
		end

	get_y_width:INTEGER_32
		do
		    RESULT:=y_width
		end

feature --Setters
	placer_origine
		do
		    x:= 100
		    y:= 200
		end


end
