note
	description: "Summary description for {BUCHES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUCHES
inherit
    ELEMENT_MOBILE
create
    make

feature --constructeur
	make(a_longeur, a_x, a_y:INTEGER_8)
		--crée une instance d'une buche selon  la longeur (0=courte, 1=moyen, 3=long)
		--valeurs de base
		do
			direction:= true
			x:=a_x
			y:=a_y
			y_width:=10
			set_delais
		    if a_longeur = 0 then
		    	---faire la petite buche
		    	make_petite
		    elseif a_longeur = 1 then
		    	-- fair la buche moyenne
		    	make_moyenne
		    elseif a_longeur = 3 then
		        --faire la grosse buche
		        make_grosse
		    else
		    	--faire la petite buche
		    	make_grosse
		    end
		    calculer_x_max (x)
		    calculer_x_min (x)

		end

	make_petite
		--crée une petite buche
		do
			x_width:=30
		end

	make_moyenne
		--crée une moyenne buche
		do
		    x_width:=40
		end
	make_grosse
		--crée une grosse buche
		do
		    x_width:=60
		end

end
