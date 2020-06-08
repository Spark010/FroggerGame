note
	description: "Class pour les voitures roulant sur la route"
	author: "Francis Croteau"
	date: "2020-02-22"

class
	VEHICULES
inherit
	ELEMENT_MOBILE
	GAME_TEXTURE
		rename
			make as make_texture
		end

create
    make

feature --acces
	x:INTEGER_32
	--position horizontale du véhicule sur la carte
	y:INTEGER_32
	--position verticale du véhicule sur la carte
	longeur:INTEGER_32
	--longeur du véhicule: nombre de pixel sur l'axe horizontale occupé par le véhicule
	largeur:INTEGER_32
	--largeur du véhicule: nombre de pixel sur l'axe vertical occupé par le véhicule
	direction:BOOLEAN
	--direction dans laquelle le véhicule se déplace
	--si vrai le véhicule de déplace de gauche a droite
	--de droite a gauche si la valeur est Faux
	est_camion:BOOLEAN
	--détermine le sprite et la longeur utiliser pour le véhicule.
	--si le véhicule est une voiture c'est faux
	--si le véhicule est vrai c'est un cammion
	en_colision:BOOLEAN
	--indique si `JOUEUR' est en colision avec `current'

feature --make
	make(a_x, a_y:INTEGER_32; a_direction, a_est_camion:BOOLEAN; a_renderer:GAME_RENDERER)
		--constructeur par défaut assigne les valeur par défaut au véhicule
		local
		    l_image:IMG_IMAGE_FILE
	   	do
	   	    x := a_x
	   	    y := a_y
	   	    est_camion:=a_est_camion
	   	    direction:=a_direction
	   	    direction := a_direction
	   	    largeur :=15
	   	    set_delais
	   	    has_error := False
	   	    en_colision := false
	   	    if est_camion then
	   	        --assigne sprite camion
	   	        longeur:=55
	   	        if (direction) then
	   	            create l_image.make ("camion_D.png")
	   	        else
	   	            create l_image.make ("camion_G.png")
	   	        end
	   	    else
	   	        ---assigne sprite voiture
	   	        longeur:=27
	   	        if direction then
	   	            create l_image.make ("voiture_D.png")
	   	        else
	   	            create l_image.make ("voiture_G.png")
	   	        end
	   	    end
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
	   	    --appelle la fonction depuis `ELEMENT_MOBILE' permet d'assigner la valeur de vitesse de déplacement
	   	end


feature --Implements
    deplacer
    	--appele la fonction bouger de ELEMENT_MOBILE pour déplacer la voiture
		do
		    x:=bouger(x, direction)
		end

	set_x_spawn(a_taille_fenetre_x:INTEGER_32)
		--remet le véhicule sur des coordonnées d'origine sur l'axe horizontale selon sa direction
		do
			if direction then
				x:=0-longeur
			else
			    x:=a_taille_fenetre_x
			end
		end
end
