note
	description: "Class des bûches de frogger ."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUCHES
inherit
    ELEMENT_MOBILE
create
    make_defaut

feature --Implentation
	x:INTEGER_32
	y:INTEGER_32
	longeur:INTEGER_32
	largeur:INTEGER_32
	direction:BOOLEAN

feature --constructors

	make_defaut(a_x, a_y:INTEGER_32 a_direction:BOOLEAN)
		--crée la buche par defaut
		do
		    x:=a_x
		    y:=a_y
		    largeur:=15
		    direction:=a_direction
		    make_petite
		    set_delais
		end


	make_petite
		--crée une petite buche
		do
			longeur:=30
			--1 sprite section bout_a
			--1 sprite section centre
			--1 sprite section bout_b
		end

		make_moyenne
		--crée une moyenne buche
		do
		    longeur:=60
		    --1 sprite section bout_a
		    --2 sprite section centre
		    --1 sprite section bout_b
		end

		make_grosse
		--crée une grosse buche
		do
		    longeur:=90
		    --1 sprite section bout_a
		    --3 sprite section centre
		    --1 sprite section bout_b
		end

feature --Implements
	deplacer
		do
			--appele la fonction bouger de ELEMENT_MOBILE pour déplacer la bûche
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
