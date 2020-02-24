note
	description: "Summary description for {VOITURES}. Class pour les voitures roulant sur la route"
	author: "Francis Croteau"
	date: "2020-02-22"
	revision: "$Revision$"

class
	VOITURES
inherit
	ELEMENT_MOBILE
	feature
			position_y:INTEGER_32 -- une fois assigné elle ne doit pas changer le temps du niveau
	   		type:BOOLEAN -- true=auto false=camion
	   		couleur:INTEGER_8 -- 1=rouge 2=bleue 3=vert



		make
	    	do

	    	    position_y := 150
	    	    type := TRUE
	    	    couleur := 2
	    	    x := 0
	    	    x_min := -20
	    	    x_max := 200
	    	    delais_deplacement := 0
	    	    delais_deplacement_max :=  2
	    	    direction := TRUE


	    	end

		get_x:INTEGER_32
			do
				RESULT := x
			end

	    bouger_voiture
			do
			    bouger
			end

end
