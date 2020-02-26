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
    make

feature
   		type:INTEGER_8 --1=voiture 2=courseA 3=courseB 4=buldoser 5=cammion

	make(a_x, a_y:INTEGER_32 a_type:INTEGER_8 a_direction:BOOLEAN)
	   	do
	   	    type := a_type
	   	    x := a_x
	   	    y := a_y
	   	    direction := a_direction
	   	    x_width := 27
	   	    y_width :=15
	   	    calculer_x_max (x)
	   	    calculer_x_min (x)
	   	    set_delais
	   	   
	   	end

	get_x:INTEGER_32
		do
			RESULT := x
		end
	get_y:INTEGER_32
		do
			RESULT := y
		end

	get_y_width:INTEGER_32
		do
			RESULT := y_width
		end

	get_x_width:INTEGER_32
		do
			RESULT := x_width
		end

    bouger_voiture
		do
			--appele la fonction bouger de ELEMENT_MOBILE pour déplacer la voiture
		    bouger
		end

end
