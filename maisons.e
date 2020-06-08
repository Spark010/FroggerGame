note
	description: "Zones de but {MAISONS} de frogger."
	author: "Francis Croteau"
	date: "2020-06-03"

class
	MAISONS
inherit
    GAME_TEXTURE
    	rename
    	    make as make_texture
    	end

create
	make

feature --acces
	est_occuper:BOOLEAN
	--indique si `Current' "possede" deja un `JOUEUR'
	x:INTEGER_32
	--position sur l'axe des x de `Current'
	y:INTEGER_32
	--position sur l'axe des y de `Current'


feature --implement
	make(a_renderer:GAME_RENDERER; a_x, a_y:INTEGER_32)
		--crée l'instance de la classe et assigne l'image de vie
		local
		    l_image:IMG_IMAGE_FILE
		do
			x:=a_x
			y:=a_y
			est_occuper:= false
			create l_image.make ("maison_libre.png")
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

feature
    occuper_maison(a_renderer:GAME_RENDERER)
    	--occupe `current'
    	local
    	    l_image:IMG_IMAGE_FILE
    	do
    		est_occuper:=true
    		create l_image.make ("maison_occuper.png")
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
end
