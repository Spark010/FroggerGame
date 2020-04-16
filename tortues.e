note
	description: "Summary description for {TORTUES}.Définie une tortue, platforme"
	author: "Francis Croteau"
	date: "2020-02-23"
	revision: "$Revision$"

class
	TORTUES
inherit
    ELEMENT_MOBILE
create
    make

feature --attributs
	x:INTEGER_32
	y:INTEGER_32
	longeur:INTEGER_32
	largeur:INTEGER_32
	direction:BOOLEAN
	temps_etat:INTEGER_32
	etat:BOOLEAN -- vrai au-dessus de l'eau : faux en plongé


feature --INITIALIZE

	make(a_x, a_y:INTEGER_32 a_direction:BOOLEAN )
		do
		    temps_etat := 60*3 --s'attend a 60fps
		    direction:= a_direction
			set_delais
			x:=a_x
			y:=a_y
			largeur:=15
			longeur:=60
		end


feature --Implementation
	changer_etat
		--change le sprite et l'état des tortues et réinitialise le compteur de temps
		do
		    if etat then
		        etat := FALSE
		        --changement du sprite a l'état flotaison
		    else
		        etat := TRUE
		        --changement du sprite a l'état de plongé
		    end
		    if etat then
		        temps_etat:= 60*2
		    else
		        temps_etat:= 60*6
		    end
		end


	compteur_etat
		do
			--déincrémente l'état et appelle la fonction de changement d'état si nécessaire
			temps_etat := temps_etat - 1
			if temps_etat <= 0 then
			    changer_etat
			end
		end

	deplacer
		do
			--appele la fonction bouger de ELEMENT_MOBILE pour déplacer les tortues et changer leur état
		    x:=bouger(x, direction)
		    compteur_etat
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
