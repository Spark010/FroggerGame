note
	description: "Summary description for {ELEMENT_MOBILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ELEMENT_MOBILE

feature {NONE} -- Implementation
	x:INTEGER_32
	x_min:INTEGER_32
	x_max:INTEGER_32
	x_width:INTEGER_32 --largeur
	y:INTEGER_32
	y_min:INTEGER_32
	y_max:INTEGER_32
	y_width:INTEGER_32 --hauteur
	direction:BOOLEAN
	delais_deplacement:INTEGER_16
	delais_deplacement_max:INTEGER_16


		deplacer
			--effectue le déplacement de `Current' sur l'axe des `x'
		do
			if direction then
				--vers la droite
		   		x := x+10
		    	if x > x_max then
		        	x := x_min
		    	end
		    else
		    	--vers la gauche
		    	x := x-10
		    	if x < x_min then
		    		x := x_max
		    	end
			end
		end

	bouger
		--s'occupe de géré le déplacement sur son interval
		do
		    delais_deplacement := delais_deplacement+1
		    if delais_deplacement > delais_deplacement_max then
		       deplacer
		       delais_deplacement := 0
		    end
		end

	set_delais
		do
		    delais_deplacement:=0
		    delais_deplacement_max:=50
		end

	calculer_x_max(a_x:INTEGER_32)
		do
			x_max := 256+x_width
		end

	calculer_x_min(a_x:INTEGER_32)
		do
			x_min := 0-x_width
		end
end
