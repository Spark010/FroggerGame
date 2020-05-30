note
	description: "Classe joueur, définie les spécificité du joueur."
	author: "Francis Croteau"
	date: "2020-02-17"
	revision: "2020-05-14"

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
	vie:INTEGER
	--nombre de tentative à la quelle le joueur as le droit d'entammer
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

feature --constructeur
	make(a_nom:STRING; a_renderer:GAME_RENDERER)
		--assignation des attributs par 'défault'
		local
	    l_image:IMG_IMAGE_FILE
		do
			nom:=a_nom
			vie:=3
			--sur l'axe des x
			longeur:=15
			--sur l'axe des y
			largeur:=15
			placer_origine
			en_deplacement:=False
			direction:=0
			compteur_deplacement:=0
			deplacement_max:=15
			score:=0
			temps_jeux:=50*60
			calculer_barre_temps
			has_error := False
			create l_image.make ("frogger_standing.png")
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
			temps_jeux:= temps_jeux-1
			calculer_barre_temps
			if en_deplacement then
				--si on est en déplacement
			    compteur_deplacement := compteur_deplacement -1
			    if compteur_deplacement > -1 then
			    	--si le déplacement est toujours valide on y vas selon la direction
			    	if direction = 0 then
			    		--bouger_haut
			    		y:= y-1
			    	elseif direction = 1 then
			    		--bouger_bas
			    		y:= y+1
			    	elseif direction = 2 then
						--bouger_droite
						x:= x+1
					elseif direction = 3 then
						--bouger_gauche
					    x:= x-1
					end
			    else
			    	--ici on as finit le déplacement ou on est pas en déplacement
			    	en_deplacement:= FALSE
			    	compteur_deplacement:=deplacement_max
			    end
			end
		end

	bouger_haut
		--on bouge en haut
		do
			if not en_deplacement then
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=0
			end
		end

	bouger_bas
		--on bouge en bas
		do
			if not en_deplacement then
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=1
			end
		end

	bouger_droite
		--on bouge a droite
		do
			if not en_deplacement then
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=2
			end
		end

	bouger_gauche
		--on bouge a gauche
		do
			if not en_deplacement then
				score:=score+10
				en_deplacement:=TRUE
	   			direction:=3
			end
		end

	calculer_barre_temps
		--calcule la longeur que la barre de temps doit être
		do
			barre_temps:= temps_jeux//60
		end


feature --Setters
	placer_origine
		--place le joueur a ses coordonées d'origine et lui enleve une vie
		do
		    x:= 150
		    y:= 270
		    vie:=vie-1
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
end
