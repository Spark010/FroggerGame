note
	description: "Classe joueur, définie les spécificité du joueur."
	author: "Francis Croteau"
	date: "2020-02-17"

class
	JOUEUR


inherit
    GAME_TEXTURE
    	rename
    	    make as make_texture
    	end

create
	make


feature -- Initialization
	nombre_vie:INTEGER_32
	--indique le nombre de vie que possède froggeur
	nom:STRING
	--nom du joueur
	x:INTEGER_32
	--position vertical de `Current'
	longeur:INTEGER_32
	--taille sur l'axe des x
	y:INTEGER_32
	--position horizontal de `Current'
	largeur:INTEGER_32 --taille sur l'axe des y
	en_deplacement:BOOLEAN
	--vrai = le joueur est en train de bouger, faux = le joueur as attein sa position
	direction:INTEGER_32
	--direction de `Current' 0=haut 1=bas 2=droite 3=gauche
	compteur_deplacement:INTEGER_32
	--compteur d'itération du déplacement du joueur (compte le temps qu'aucun autre entrée est accepté)
	deplacement_max:INTEGER_32
	--valeur maximale du compteur de déplacement du joueur, sert comme clause d'ajustement pour déplacer le joueur
	score:INTEGER_32
	--valeur de pointage de la partie c'est utiliser pour le palmares des scores
	--table de points: 10points par pas, 50/frog souvé(en maison), 1000points/sauver 5 frog on stage, 10pts/secondes restantes
	temps_jeux:INTEGER_32
	--temps pour une vie ce qui veux dire le temps donner au joueur pour se rendre de l'autre coté
	barre_temps:INTEGER_32
	--longeur de la barre de temps à afficher selon le temps restant
	sprite_pret:READABLE_STRING_GENERAL
	--valeur de l'emplacement de l'image à l'arrêt
	sprite_saute:READABLE_STRING_GENERAL
	--valeur de l'emplacement de l'image en saut
	sprite_atterris:READABLE_STRING_GENERAL
	--valeur de l'emplacement de l'image d'atterissage
	sprite_mort:READABLE_STRING_GENERAL
	--valeur de l'emplacement de l'image de la mort
	est_en_vie:BOOLEAN
	--indique si frogger est en vie
	compteur_mort:INTEGER_32
	--indique combien de temps le jeux reste imobile
	est_sur_mobile:BOOLEAN
	--indique si `Current' est sur un `ELEMENT_MOBILE'
	direction_mobile:BOOLEAN
	--indique la direction de l' `ELEMENT_MOBILE' sur le quel `Current' est "attacher"
	est_sur_route:BOOLEAN
	--indique si `Current' est sur la route dans le `PAYSAGE' ou si il est sur la rivière
	peut_etre_sur_mobile:BOOLEAN
	--indique si `Current' effectue un saut il peut atterrir sur un `ELEMENT_MOBILE'


feature --constructeur
	make(a_nom:STRING; a_renderer:GAME_RENDERER)
		--assignation des attributs par 'défault'
		local
	    l_image:IMG_IMAGE_FILE
		do
			nom:=a_nom
			--sur l'axe des x
			longeur:=15
			--sur l'axe des y
			largeur:=15
			direction:=0
			compteur_deplacement:=0
			deplacement_max:=15
			score:=0
			temps_jeux:=50*60
			compteur_mort:= 60*3
			nombre_vie:=7
			sprite_pret:="frogger_pret_H.png"
			sprite_saute:="frogger_saute_H.png"
			sprite_atterris:="frogger_atterris_H.png"
			sprite_mort:="frogger_mort.png"
			en_deplacement:=false
			has_error := false
			est_en_vie:=true
			est_sur_mobile:=false
			est_sur_route:=true
			peut_etre_sur_mobile:=false
			placer_origine
			calculer_barre_temps
			create l_image.make (sprite_pret)
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

feature --Acces
	bouger
		--bouge le joueur selon la direction et le temps de déplacement
		do
    		if en_deplacement then
    		--si on est en déplacement
    		compteur_deplacement := compteur_deplacement -1
    			if compteur_deplacement > -1 then
    				--si le déplacement est toujours valide on y vas selon la direction
    				if direction = 0 then
    				bouger_haut
    				y:= y-1
    				elseif direction = 1 then
    					bouger_bas
    			    	y:= y+1
    				elseif direction = 2 then
    					bouger_droite
    					x:= x+1
    				elseif direction = 3 then
    					bouger_gauche
    					x:= x-1
    				end
    			else
    				--ici on as finit le déplacement ou on est pas en déplacement
    				en_deplacement:= false
    				compteur_deplacement:=deplacement_max
				end
    	    end
		end

	appliquer_action(a_renderer:GAME_RENDERER)
		--applique les action de `Current' selon son état
		do
			if est_en_vie then
				temps_jeux := temps_jeux-1
				if (temps_jeux >= 0) then
					bouger
				else
					frogger_meurt
				end
			else
				frogger_meurt
			end
			etat_position
			update_sprite(a_renderer)
			calculer_barre_temps
		end




	update_sprite(a_renderer:GAME_RENDERER)
		--met à jour la texture de `JOUEUR'
		local
		    l_image:IMG_IMAGE_FILE
		do
			if est_en_vie then
			    if en_deplacement then
			    	if (compteur_deplacement > 0 ) then
			    	    create l_image.make (sprite_saute)
			    	elseif (compteur_deplacement > 3 and compteur_deplacement < 10) then
			    	    create l_image.make (sprite_atterris)
			    	else
			    	    create l_image.make (sprite_pret)
			    	end
			    else
			    	create l_image.make (sprite_pret)
				end
			else
				create l_image.make (sprite_mort)
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


	bouger_haut
		--on bouge en haut
		do
			if not en_deplacement then
				--si c'est le déplacement initiale
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=0
	   			--will add sound :D
	   			sprite_pret:="frogger_pret_H.png"
				sprite_saute:="frogger_saute_H.png"
				sprite_atterris:="frogger_atterris_H.png"
				if est_sur_mobile then
					correction_position
				end
			end
		end

	bouger_bas
		--on bouge en bas
		do
			if not en_deplacement then
				--si c'est le déplacement initiale
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=1
	   			sprite_pret:="frogger_pret_B.png"
				sprite_saute:="frogger_saute_B.png"
				sprite_atterris:="frogger_atterris_B.png"
				if est_sur_mobile then
					correction_position
				end
			end
		end

	bouger_droite
		--on bouge a droite
		do
			if not en_deplacement then
				--si c'est le déplacement initiale
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=2
	   			sprite_pret:="frogger_pret_D.png"
				sprite_saute:="frogger_saute_D.png"
				sprite_atterris:="frogger_atterris_D.png"
				if est_sur_mobile then
					correction_position
				end
			end
		end

	bouger_gauche
		--on bouge a gauche
		do
			if not en_deplacement then
				--si c'est le déplacement initiale
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=3
	   			sprite_pret:="frogger_pret_G.png"
				sprite_saute:="frogger_saute_G.png"
				sprite_atterris:="frogger_atterris_G.png"
				if est_sur_mobile then
					correction_position
				end
			end
		end

	calculer_barre_temps
		--calcule la longeur que la barre de temps doit être
		do
			barre_temps:= temps_jeux//60
		end

	correction_position
		--corrige la position horizontale du joueur (axe des x) selon le multiple de 15 le plus proche
		--ce n'est pas une méthode parfaite mais c'est asser proche pour un jeux

		do
			   x:=((x+7)//15)*15
		end

	frogger_meurt
		--enleve une vie a `Current' et s'assure que sa position est imobile durant 3 secondes
		local
		    l_image:IMG_IMAGE_FILE
		do
		    if est_en_vie then
		    	create l_image.make (sprite_mort)
		    	nombre_vie := nombre_vie-1
		    	est_en_vie:=false
		    	en_deplacement:=false
		    	est_sur_route:=true
		    	est_sur_mobile:=false
		    	temps_jeux:=50*60
		    	compteur_mort:= 60*3
		    else
		    	if (compteur_mort > 0) then
		    		compteur_mort:= compteur_mort -1
		    	else
		    		est_en_vie:=true
		    		placer_origine
		    	end
		    end
		end

	etat_position
		--vérifie si le joueur est sur la route
		do
			if (y>104 and y < 179) then
				est_sur_route:=false
				if (not est_sur_mobile or not peut_etre_sur_mobile) then
					frogger_meurt
				end
			else
				est_sur_route:=true
			end
		end

feature --Setters
	placer_origine
		--place le joueur a ses coordonées d'origine et on le remet en vie
		do
		    x:= 150
		    y:= 270
		    est_en_vie:= true
		end

	 set_x(a_x:INTEGER_32)
	 	--place le joueur sur la coordonée de l'axe des x (horizontal) demandé
	 	do
	 	    x:= a_x
	 	end

	set_y(a_y:INTEGER_32)
		--place le joueur sur la coordonée de l'axe des y (vertical) demandé
		do
		    y:=a_y
		end

	attacher_sur_mobile(a_direction_mobile:BOOLEAN)
		--place les drapeau de `Current' sur la direction de déplacement de `ELEMENT_MOBILE' pour permetre la syncronisation de déplacement
		do
			est_sur_mobile:=true
			if a_direction_mobile then
				--droite à gauche
				x:=x+1
			else
				--gauche à droite
				x:=x-1
			end
		end

	peut_sauter(a_peut_etre_sur_mobile:BOOLEAN)
		--change l'état de de l'atterissage de `Current'
		do
			peut_etre_sur_mobile:=a_peut_etre_sur_mobile
		end

end
