note
    description : "Frogger pour Game2 sur le langague Eiffel."
    author      : "Francis Croteau"
    generator   : "Eiffel Game2 Project Wizard"
    date        : "2020-02-03 03:36:46.066 +0000"

class
    APPLICATION
inherit
	GAME_LIBRARY_SHARED --librairie standard pour le jeux
	IMG_LIBRARY_SHARED --pour utiliser `image_file_library'
	TEXT_LIBRARY_SHARED --pour utiliser du texte surfacer dans la fênetre de jeux

create
    make

feature {NONE} -- Initialization

    make
            -- Running the game.
        local
        	l_moteur:MOTEUR
        do
        	game_library.enable_video -- active les fonctionnalités vidéo
        	text_library.enable_text --active le support du texte
        	image_file_library.enable_image (true, false, false) --Active le support des image PNG seulement
            create l_moteur.make --crée le moteur du jeux
            l_moteur.lancer --lance le moteur

        end

end
