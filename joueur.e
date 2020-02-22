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
			position_grille_x:=0
			position_grille_y:=0
			id_sprite_frogger:=0
		end

feature --attributs/variables
	vie: INTEGER_32
	nom: STRING
	position_grille_x: INTEGER_32
	position_grille_y: INTEGER_32
	id_sprite_frogger: INTEGER_8 --0 rest, 1 crank, 2 jump, 3 land, 4 in water, 5 flat, 6 eaten
end
