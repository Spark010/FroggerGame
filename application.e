note
    description : "A game created in Eiffel."
    author      : "Francis Croteau"
    generator   : "Eiffel Game2 Project Wizard"
    date        : "2020-02-03 03:36:46.066 +0000"
    revision    : "0.1"

class
    APPLICATION
inherit
	GAME_LIBRARY_SHARED

create
    make

feature {NONE} -- Initialization

    make
            -- Running the game.
        local
        	l_moteur:MOTEUR
            temp:JOUEUR
        do
        	game_library.enable_video
            create l_moteur.make
            l_moteur.lancer

        end

end
