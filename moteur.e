note
	description: "Summary description for {MOTEUR}."
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
	make
			-- Initialise `Curent'

		local
			l_builder:GAME_WINDOW_RENDERED_BUILDER
		do
		    create l_builder
			create auto
			auto.make
		    l_builder.set_dimension (200, 300)
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
		    l_compteur_delais_bouger:INTEGER_16
		    pos_x:INTEGER_32

		do
			pos_x := auto.get_x
			create l_couleur.make_rgb (0, 0, 0)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.clear
		    create l_couleur.make_rgb (0, 0, 255)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (auto.get_x, 10, 20, 10)
		    create l_couleur.make_rgb (0, 255, 0)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (100, 200, 5, 5)
		    fenetre.renderer.present
		    auto.bouger_voiture
		end

	on_quit(a_timestamp:NATURAL)
		-- Lorsque l'utilisateur quitte le program
		do
		    game_library.stop
		end


end
