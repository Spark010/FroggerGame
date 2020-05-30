note
	description: "{PAYSAGE} est le font d'écran du jeux"
	author: "Francis Croteau"
	date: "2020-05-14"
	revision: "$2020-05-14 12:08pm"

class
	PAYSAGE
inherit
    GAME_TEXTURE
    	rename
    		make as make_texture
    	end
create
	make

feature {NONE} --initialisation
	--source de l'exemple anime_surfaced class DESERT.e
	make(a_renderer:GAME_RENDERER)
		--Initialisation de `Current' pour son utilisation avec `a_renderer'
		local
		    l_image: IMG_IMAGE_FILE
		do
		    create l_image.make("bg.png")
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
