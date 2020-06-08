note
	description: "Summary description for {BADGE_VIE}."
	author: "Francis Croteau"
	date: "$2020-06-02"

class
	BADGE_VIE
inherit
    GAME_TEXTURE
    rename
    	make as make_texture
    end

create
    make

feature --acces
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
			create l_image.make ("frogger_vie.png")
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
