note
	description: "Summary description for {MOTEUR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MOTEUR
inherit
    GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialisation
	make
			-- Initialise `Curent'
		local
			l_builder:GAME_WINDOW_RENDERED_BUILDER
		do
		    create l_builder
		    l_builder.set_dimension (100, 400)
		    l_builder.set_title ("Frogger")
		    fenetre := l_builder.generate_window
		end

feature --Acces

	lancer
			--Démare le programme
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			game_library.iteration_actions.extend (agent on_interation)
			game_library.launch
		end
	fenetre:GAME_WINDOW_RENDERED
		-- permet d'afficher la scène
feature {NONE} --Implémentation

	on_interation(a_timestamp:Natural)
		--A chaque tour de la boucle de la librairie de jeu
		local
		    l_couleur:GAME_COLOR
		do
			create l_couleur.make_rgb (0, 0, 0)
		    fenetre.renderer.clear
		    create l_couleur.make_rgb (0, 0, 255)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_rectangle (10, 100, 10, 10)
		    fenetre.renderer.draw_filled_rectangle (20, 120, 10, 10)
		    fenetre.renderer.present
		end
	on_quit(a_timestamp:NATURAL)
		-- Lorsque l'utilisateur quitte le program
		do
		    game_library.quit_signal_actions.extend (agent on_quit)
		end
end
