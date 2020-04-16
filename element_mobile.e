note
	description: "Classe qui s'occupe du mouvement des �l�ments mobiles du jeux."
	author: "Francis Croteau"
	date: "2020-03-2"
	revision: "01"

deferred class
	ELEMENT_MOBILE

feature -- Implementation
	delais_deplacement:INTEGER_16
	delais_deplacement_max:INTEGER_16

	bouger(a_x:INTEGER_32 a_direction:BOOLEAN):INTEGER_32
		--s'occupe de g�r� le d�placement sur son interval
		local
		l_x:INTEGER_32
		--code
		do
			l_x := a_x --pour le r�sultat si rien ne change
		    delais_deplacement := delais_deplacement + 1
		    --si le d�lais du d�placement est attein on d�place selon la direction
		    if delais_deplacement > delais_deplacement_max then
		    	if a_direction then
					--vers la droite
		   			l_x := a_x + 1
		   			--on ramene le compteur de d�lais � 0 car on s'est d�placer
		   			delais_deplacement := 0
		    	else
		    		--vers la gauche
		   			l_x := a_x - 1
		   			--on ramene le compteur de d�lais � 0  car on s'est d�placer
		   			delais_deplacement := 0
		    	end
		    end
		    RESULT := l_x
		end

	set_delais
		--assigne les valeurs par d�fault du d�lais de d�placement
		do
		    delais_deplacement := 0
		    delais_deplacement_max := 2
		end
end
