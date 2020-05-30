note
	description: "Classe des tortues de frogger"
	author: "Francis Croteau"
	date: "2020-02-23"
	revision: "2020-05-14"

class
	TORTUES
inherit
    ELEMENT_MOBILE
    GAME_TEXTURE
    	rename
    	    make as make_texture
    	end

create
    make

feature --attributs
	x:INTEGER_32
	--position sur l'axe horizontale de la tortue
	y:INTEGER_32
	--position sur l'axe verticale de la tortue
	longeur:INTEGER_32
	--grandeur occupé en pixel sur l'axe horizontal occupé par la tortue
	largeur:INTEGER_32
	--grandeur occupé en pixel sur l'axe vertical occupé par la tortue
	direction:BOOLEAN
	--indique la direction prise par la tortue, vrai = de droite à gauche , faux = de gauche à droite
	temps_etat:INTEGER_32
	--itérateur du nombre de cycle de l'application durant lequel l'état actuelle est maintenue'
	etat:BOOLEAN
	-- Indiquateur de l'état de la tortue vrai au-dessus de l'eau : faux en plongé


feature --INITIALIZE

	make(a_x, a_y:INTEGER_32; a_direction:BOOLEAN; a_renderer:GAME_RENDERER )
		--constructeur par défaut : initialise les valeur par défaut
		local
		    l_image:IMG_IMAGE_FILE
		do
		    temps_etat := 60*3
		    --s'attend a 60fps
		    direction:= a_direction
			set_delais
			x:=a_x
			y:=a_y
			largeur:=15
			longeur:=60
			create l_image.make ("tortue1.png")
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
		end


feature --Implementation

	compteur_etat(a_renderer:GAME_RENDERER) --i was making it able to change the sprite, it can but it's weird
		do
			--déincrémente l'état et appelle la fonction de changement d'état si nécessaire
			temps_etat := temps_etat - 1
			if temps_etat <= 0 then
			    if etat then
			    	--on plonge
		        	etat := false
		        	temps_etat:= 60*2
		        else
		        	--on est pas en plonger alors on flotte
		        	etat := true
		        	temps_etat:= 60*6
		        end
		    end
		    changement_etat(a_renderer)
		end

		changement_etat(a_renderer:GAME_RENDERER)
		local
			l_image:IMG_IMAGE_FILE
		do
			create l_image.make ("tortue1.png")
		    if etat then
		    	l_image := mettre_ajour_sprite_flotter
		    	print("flotte %N")
		    else
		    	l_image := mettre_ajour_sprite_plonger
		    	print("plonge %N")
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
		end

	mettre_ajour_sprite_flotter: IMG_IMAGE_FILE
	local
	    l_image:IMG_IMAGE_FILE
	do
		create l_image.make ("tortue1.png") -- image par defaut
	    --changement du sprite a l'état de plongé en 3 étape
		if (temps_etat < 60*6 and temps_etat > 60*6-10)then
			create l_image.make ("tortue4.png")
		elseif (temps_etat < 60*6-10 and temps_etat > 60*6-20) then
			create l_image.make ("tortue3.png")
		elseif (temps_etat < 60*6-20 and temps_etat > 60*6-30) then
			create l_image.make ("tortue2.png")
		elseif (temps_etat < 60*6-30) then
			create l_image.make ("tortue1.png")
		end
		Result := l_image
	end

	mettre_ajour_sprite_plonger: IMG_IMAGE_FILE
	local
	    l_image:IMG_IMAGE_FILE
	do
		--changement du sprite a l'état de plongé en 3 étape
		create l_image.make ("tortue4.png") -- image par defaut
	    if (temps_etat < 60*2 and temps_etat > 60*2-10)then
			create l_image.make ("tortue2.png")
		elseif (temps_etat < 60*2-10 and temps_etat > 60*2-20) then
		    create l_image.make ("tortue3.png")
		elseif temps_etat < 60*2-20 then
			create l_image.make ("tortue4.png")
		end
		Result := l_image
	end


	deplacer(a_renderer:GAME_RENDERER)
		do
			--appele la fonction bouger de ELEMENT_MOBILE pour déplacer les tortues
			--et appelle la fonction du compteur d'état leur état
		    x:=bouger(x, direction)
		    compteur_etat(a_renderer)
		end

	set_x_spawn(a_taille_fenetre_x:INTEGER_32)
		--remet la tortue sur des coordonnées d'origine sur l'axe horizontale selon sa direction
		do
			if direction then
				x:=0-longeur
			else
			    x:=a_taille_fenetre_x
			end
		end
end
