note
	description: "Classe qui s'occupe du mouvement des éléments mobiles du jeux."
	author: "Francis Croteau"
	date: "2020-03-2"
	revision: "01"

deferred class
	ELEMENT_MOBILE

feature -- Implementation
	delais_deplacement:INTEGER_16
	delais_deplacement_max:INTEGER_16

	bouger(a_x:INTEGER_32 a_direction:BOOLEAN):INTEGER_32
		--s'occupe de géré le déplacement sur son interval
		local
		l_x:INTEGER_32
		--code
		do
			l_x := a_x --pour le résultat si rien ne change
		    delais_deplacement := delais_deplacement + 1
		    --si le délais du déplacement est attein on déplace selon la direction
		    if delais_deplacement > delais_deplacement_max then
		    	if a_direction then
					--vers la droite
		   			l_x := a_x + 1
		   			--on ramene le compteur de délais à 0 car on s'est déplacer
		   			delais_deplacement := 0
		    	else
		    		--vers la gauche
		   			l_x := a_x - 1
		   			--on ramene le compteur de délais à 0  car on s'est déplacer
		   			delais_deplacement := 0
		    	end
		    end
		    RESULT := l_x
		end

	set_delais
		--assigne les valeurs par défault du délais de déplacement
		do
		    delais_deplacement := 0
		    delais_deplacement_max := 2
		end
end
