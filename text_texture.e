note
	description: "Class qui g�n�re des texture � partir de string {TEXT_TEXTURE}."
	author: "Francis Croteau"
	date: "2020-05-29"
	revision: "0.1"

class
	TEXT_TEXTURE

create
	make

feature --Acces
	text_texture:GAME_TEXTURE
	--G�n�rateur de texture
	text_surfaced:TEXT_SURFACE_BLENDED
	--utiliser pour g�n�rer les element de text en surface que l'on converti en texture
	fonte:TEXT_FONT
	--la fonte utiliser pour dessiner le texte
	couleur_texte:GAME_COLOR_READABLE
	--d�termine la couleur du texte
	texte:STRING
	--le texte que l'on veux cr�er
	has_error:BOOLEAN
	--utiliser pour indiquer si la classe as une erreur lors de sa cr�ation

feature --implement
	make(a_texte:STRING; a_renderer:GAME_RENDERER)
		local
		do
			--assignation des valeur au variables
			texte := a_texte
			create fonte.make("fonte.ttf", 8)
			if fonte.is_openable then
				fonte.open
				has_error := not fonte.is_open
			else
				has_error := True
			end
			create couleur_texte.make_rgb (255, 255, 255)
		    create text_surfaced.make(texte, fonte, couleur_texte)
		    create text_texture.make_from_surface (a_renderer, text_surfaced)
		    --je doit trouver comment cr�er un GAME_TEXTURE  car il me manque des �l�ments...
		end





end
