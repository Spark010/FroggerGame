note
	description: "Summary description for {LILYPADS}.Définie un nénuphar , Ennemie du joueur, platforme"
	author: "Francis Croteau"
	date: "2020-02-23"
	revision: "$Revision$"

class
	LILYPADS
inherit
    ELEMENT_MOBILE
create
    make

feature --INITIALIZE
	temps_vie:INTEGER_16

	make(a_x, a_y:INTEGER_32 a_direction:BOOLEAN )
		do
		    temps_vie := 40
		    direction:= a_direction
			set_delais
			x:=a_x
			y:=a_y
			y_width:=10
			x_width:=60
			calculer_x_max (x)
			calculer_x_min (x)
		end

feature --utiliser
	supporter_frogger
		do
			temps_vie := temps_vie - 1
			if temps_vie.is_less_equal (0) then
			    --on tue frogger
			    --on ramene a la vie la plante
			    temps_vie:= 40
			end
		end


end
