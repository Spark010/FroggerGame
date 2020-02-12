note
	description: "Classe joueur, définie les spécificité du joueur."
	author: "Francis Croteau"
	date: "$Date$"
	revision: "$Revision$"

class
	JOUEUR

attribute
	vie: INTEGER_32
	nom: STRING
	position_grille_x: INTEGER_32
	position_grille_y: INTEGER_32
	id_sprite_frogger: INTEGER_32

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			--notbing for now
		end

end
