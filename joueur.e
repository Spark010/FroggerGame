note
	description: "Classe joueur, d�finie les sp�cificit� du joueur."
	author: "Francis Croteau"
	date: "$Date$"
	revision: "$Revision$"

class
	JOUEUR


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			nom:=""
		end

feature
	vie: INTEGER_32
	nom: STRING
	position_grille_x: INTEGER_32
	position_grille_y: INTEGER_32
	id_sprite_frogger: INTEGER_32
end
