note
	description: "Summary description for {MOTEUR}.moteur du jeux"
	author: "Francis Croteau"
	date: "2020-02-22"
	revision: "$Revision$"

class
	MOTEUR
inherit
    GAME_LIBRARY_SHARED

create
	make

feature {NONE} -- Initialisation
	auto:VOITURES
	joueur:JOUEUR
	make
			-- Initialise `Curent'

		local
			l_builder:GAME_WINDOW_RENDERED_BUILDER
		do
		    create l_builder
			create auto.make(0, 150, 1, TRUE)
			create joueur.make
		    l_builder.set_dimension (224, 256)
		    l_builder.set_title ("Frogger")
		    l_builder.enable_must_renderer_synchronize_update
		    fenetre := l_builder.generate_window
		end

feature --Acces

	lancer
			--Démare le programme
		do
			game_library.quit_signal_actions.extend (agent on_quit)
			game_library.iteration_actions.extend (agent on_interation)
			if fenetre.renderer.driver.is_software_rendering_supported then
		    	game_library.launch_no_delay
		    else
		        game_library.launch
		    end
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
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.clear
		    create l_couleur.make_rgb (0, 0, 255)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (auto.get_x, auto.get_y, auto.get_x_width, auto.get_y_width)
		    create l_couleur.make_rgb (0, 255, 0)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (joueur.get_x, joueur.get_y, joueur.get_x_width, joueur.get_y_width)
		    fenetre.renderer.present
		    auto.bouger_voiture
		end

	on_quit(a_timestamp:NATURAL)
		-- Lorsque l'utilisateur quitte le program
		do
		    game_library.stop
		end


end
