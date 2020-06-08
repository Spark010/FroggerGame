note
	description: "Classe qui s'occupe du mouvement des �l�ments mobiles du jeux."
	author: "Francis Croteau"
	date: "2020-03-2"

deferred class
	ELEMENT_MOBILE

feature -- Implementation
	delais_deplacement:INTEGER_16
	--it�rateur du d�lais de d�placement en cours
	delais_deplacement_max:INTEGER_16
	--valeur maximal du d�lais de d�placement
	se_deplace:BOOLEAN
	--indique si `Current' se d�place

	bouger(a_x:INTEGER_32 a_direction:BOOLEAN):INTEGER_32
		--s'occupe de g�r� le d�placement sur son interval
		local
		l_x:INTEGER_32
		do
			l_x := a_x
			--pour le r�sultat si rien ne change
		    delais_deplacement := delais_deplacement + 1
		    se_deplace:=false
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
		    	se_deplace:=true
		    end
		    RESULT := l_x
		end

	set_delais
		--assigne les valeurs par d�fault du d�lais de d�placement
		do
		    delais_deplacement := 0
		    delais_deplacement_max := 2
		    se_deplace:=false
		end

	set_no_delais
		--assigne les valeur de d�placement rapide
		do
		    delais_deplacement := 0
		    delais_deplacement_max := 0
		    se_deplace:=false
		end

	set_delais_slow
		--assigne les valeurs de d�plcaement lent
		do
		    delais_deplacement := 0
		    delais_deplacement_max := 4
		    se_deplace:=false
		end
end
