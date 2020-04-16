note
	description: "Classe joueur, définie les spécificité du joueur."
	author: "Francis Croteau"
	date: "2020-02-17"
	revision: "$Revision$"

class
	JOUEUR


create
	make

feature -- Initialization
	vie:INTEGER
	nom:STRING --nom du joueur
	x:INTEGER_32--position vertical de `Current'
	longeur:INTEGER_32 --taille sur l'axe des x
	y:INTEGER_32 --position horizontal de `Current'
	largeur:INTEGER_32 --taille sur l'axe des y
	en_deplacement:BOOLEAN --vrai le joueur est en train de bouger, --False le joueur as attein sa position
	direction:INTEGER_32 --direction de `Current' 0=haut 1=bas 2=droite 3=gauche
	compteur_deplacement:INTEGER_32
	deplacement_max:INTEGER_32

feature --constructeur
	make(a_nom:STRING)
			-- Initialization for `Current'.
		do
			--assignation des attributs par 'défault'
			nom:=a_nom
			vie:=3
			--sur l'axe des x
			longeur:=15
			--sur l'axe des y
			largeur:=15
			placer_origine
			en_deplacement:=FALSE
			direction:=0
			compteur_deplacement:=0
			deplacement_max:=15
		end

feature --Acces
	bouger
		--bouge le joueur selon la direction et le temps de déplacement
		do
			if en_deplacement then
			    compteur_deplacement := compteur_deplacement -1
			    if compteur_deplacement > -1 then
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
			    	en_deplacement:= FALSE
			    	compteur_deplacement:=deplacement_max
			    end
			end
		end

	deplacer_haut
		do
		    direction:=0
		    compteur_deplacement:=deplacement_max
		    en_deplacement:=TRUE
		end

	bouger_haut
		--on bouge en haut
		do
			if not en_deplacement then
				en_deplacement:=TRUE
	   			direction:=0
			end
		end

	bouger_bas
		--on bouge en bas
		do
			if not en_deplacement then
				en_deplacement:=TRUE
	   			direction:=1
			end
		end

	bouger_droite
		--on bouge a droite
		do
			if not en_deplacement then
				en_deplacement:=TRUE
	   			direction:=2
			end
		end

	bouger_gauche
		--on bouge a gauche
		do
			if not en_deplacement then
				en_deplacement:=TRUE
	   			direction:=3
			end
		end


feature --Setters
	placer_origine
		--place le joueur a ses coordonées d'origine
		do
		    x:= 150
		    y:= 270
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
