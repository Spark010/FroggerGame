note
	description: "Summary description for {LILYPADS}.Définie un nénuphar , Ennemie du joueur, platforme"
	author: "Francis Croteau"
	date: "2020-02-23"
	revision: "$Revision$"

class
	LILYPADS
inherit
    ELEMENT_MOBILE

feature --Accès
	make
		local
		    l_temps_vie:INTEGER_16
		do
		    l_temps_vie := 7000
		end

feature --utiliser
	supporter_frogger(l_temps_vie:INTEGER_16) : INTEGER_16
		do
			RESULT := l_temps_vie - 1
			if l_temps_vie.is_less_equal (0) then
			    --on tue frogger
			    --on ramene a la vie la plante
			    RESULT := 7000
			end
		end


end
