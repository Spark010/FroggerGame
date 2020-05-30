note
	description: "Class des b�ches de frogger ."
	author: "Francis Croteau"
	date: "2020-02-22"
	revision: "2020-05-16"

class
	BUCHES
inherit
    ELEMENT_MOBILE
    GAME_TEXTURE
    	rename
    	    make as make_texture
    	end

create
    make_defaut

feature --Implentation
	x:INTEGER_32
	--position sur l'axe horizontale de la b�che
	y:INTEGER_32
	--position sur l'axe vertical de la b�che
	longeur:INTEGER_32
	--grandeur occup� en pixel sur l'axe horizontal occup� par la b�che
	largeur:INTEGER_32
	--grandeur occup� en pixel sur l'axe vertical occup� par la b�che
	direction:BOOLEAN
	--indique la direction prise par la b�che, vrai = de droite � gauche , faux = de gauche � droite
	est_moyenne:BOOLEAN
	--indique si la buche est de taille moyenne
	est_grosse:BOOLEAN
	--indique si la buche est de grande taille

feature --constructors

	make_defaut(a_x, a_y:INTEGER_32; a_est_moyenne, a_est_grosse, a_direction:BOOLEAN; a_renderer:GAME_RENDERER)
		--cr�e la buche par defaut
		local
		    l_image:IMG_IMAGE_FILE
		do
		    x:=a_x
		    y:=a_y
		    est_grosse:=a_est_grosse
		    est_moyenne:=a_est_moyenne
		    largeur:=15
		    direction:=a_direction
		    if (est_grosse) then
		    	longeur:=90
		    	create l_image.make ("buche_g.png")
		     elseif (est_moyenne) then
		         longeur:=60
		         create l_image.make ("buche_m.png")
		     else
		         longeur:=30
		         create l_image.make ("buche_p.png")
		    end
		    has_error := False
			if l_image.is_openable then
				l_image.open
				if l_image.is_open then
					make_from_image (a_renderer, l_image)
				else
					has_error := True
				end
			else
				has_error := True
			end
		    set_delais
		end

feature --Implements
	deplacer
		--appele la fonction bouger de ELEMENT_MOBILE pour d�placer la b�che
		do

		    x:=bouger(x, direction)
		end

	set_x_spawn(a_taille_fenetre_x:INTEGER_32)
		--remet la b�che sur des coordonn�es d'origine sur l'axe horizontale selon sa direction
		do
			if direction then
				x:=0-longeur
			else
			    x:=a_taille_fenetre_x
			end
		end

end
