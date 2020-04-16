note
	description: "Summary description for {VOITURES}. Class pour les voitures roulant sur la route"
	author: "Francis Croteau"
	date: "2020-02-22"
	revision: "$Revision$"

class
	VOITURES
inherit
	ELEMENT_MOBILE

create
    make_default

feature {NONE} --make
	make_default(a_x, a_y:INTEGER_32; a_direction, a_est_camion:BOOLEAN)
	   	do
	   	    x := a_x
	   	    y := a_y
	   	    if est_camion then
	   	        --assigne sprite camion
	   	        longeur:=55
	   	    else
	   	        ---assigne sprite voiture
	   	        longeur:=27
	   	    end
	   	    direction := a_direction
	   	    largeur :=15
	   	    set_delais
	   	end
feature --acces
	x:INTEGER_32
	y:INTEGER_32
	longeur:INTEGER_32
	largeur:INTEGER_32
	direction:BOOLEAN
	est_camion:BOOLEAN

feature --Implements
    deplacer
		do
			--appele la fonction bouger de ELEMENT_MOBILE pour déplacer la voiture
		    x:=bouger(x, direction)
		end

	set_x_spawn(a_taille_fenetre_x:INTEGER_32)
		do
			if direction then
				x:=0-longeur
			else
			    x:=a_taille_fenetre_x
			end
		end
end
