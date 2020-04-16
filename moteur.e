note
	description: "Moteur du jeux"
	author: "Francis Croteau"
	date: "2020-02-22"
	revision: "$Revision$"

class
	MOTEUR
inherit
    GAME_LIBRARY_SHARED

create
	make
feature {NONE} --Attributs
	--attributs de la classe Moteur
	taille_fenetre_x:INTEGER_32
	taille_fenetre_y:INTEGER_32
	zone_maximal_y:INTEGER_32
	zone_minimal_y:INTEGER_32
	--route:LIST[VOITURES]
	--riviere1:LIST[BUCHES]
	--riviere2:LIST[LILYPADS]
	auto:VOITURES
	joueur:JOUEUR
	tortue:TORTUES
 	buche:BUCHES
	--autos:[VOITURES]

feature {NONE} -- Initialisation
	make
			-- Initialise `Curent'

		local
			l_builder:GAME_WINDOW_RENDERED_BUILDER
			l_i:INTEGER_32
		do
			--on assigne la valeur de la fenêtre. on simule une borne d'arcade a une resolution légèrement modifier
			taille_fenetre_x:=300
		    taille_fenetre_y:=330
		    zone_minimal_y:=90
		    zone_maximal_y:=270
		    --création d'objet spécifique au jeux
			create auto.make_default(0, 255, false, FALSE)
			create joueur.make("frogger")
			create tortue.make (4, 165, FALSE)
			create buche.make_defaut(0, 150, TRUE)
			--voirutres 255,240,225,210
--			l_i:=4 --nombre de voiture par ligne
--			from
--				l_i:=4
--			until
--			    l_i=-1
--			loop
--			    create auto.make_default (l_i*27+30, 255, FALSE, FALSE)
--			    route.append (auto)
--			    l_i:=l_i-1
--			end
--			l_i:=4
--			from
--			until
--				l_i=-1
--			loop
--			    create auto.make_default (l_i*27+30+90, 240, FALSE, FALSE)
--			    route.append (auto)
--			    l_i:=l_i-1
--			end
--			l_i:=4
--			from
--			until
--			    l_i=-1
--			loop
--			    create auto.make_default (l_i*27+30+60, 225, FALSE, FALSE)
--			    route.append (auto)
--			    l_i:=l_i-1
--			end
--			l_i:=4
--			from
--			until
--				l_i=-1
--			loop
--			    create auto.make_default (l_i*27+30+30, 210, TRUE, FALSE)
--			    route.append (auto)
--			    l_i:=l_i-1
--			end
--			l_i:=3
--			from
--			until
--			    l_i=-1
--			loop
--			    create auto.make_default (l_i*55+30, 195, FALSE, TRUE)
--			    route.append (auto)
--			    l_i:=l_i-1
--			end
			--cammion 195
			--tortue 165,120
			--buche 150,135, 105

			--création de la fênetre
			create l_builder
		    l_builder.set_dimension (taille_fenetre_x, taille_fenetre_y)
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
			fenetre.key_pressed_actions.extend (agent on_key_pressed)
			fenetre.key_released_actions.extend (agent on_key_released)
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
		    l_couleur_a:GAME_COLOR
		    l_couleur_b:GAME_COLOR

		do
			--rendu du fond, comme c'est un jeux d'arcade classique noir est utiliser
			create l_couleur.make_rgb (0, 0, 0)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.clear
		    --dessin des zones
		    create l_couleur_a.make_rgb (100, 100, 100)
		    create l_couleur_b.make_rgb (255, 255, 255)
		    create l_couleur.make_rgb (0,150,0)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (0, 60, taille_fenetre_y, 60)
		    fenetre.renderer.draw_filled_rectangle (0, 270, taille_fenetre_y, 15)
		    fenetre.renderer.draw_filled_rectangle (0, 180, taille_fenetre_y, 15)
		    fenetre.renderer.draw_filled_rectangle (0, 90, taille_fenetre_y, 15)
		    create l_couleur.make_rgb (150,150,150)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (0, 195, taille_fenetre_y, 75)
		    create l_couleur.make_rgb (0,0,85)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (0, 105, taille_fenetre_y, 75)

		    --mouvement Temporaire
		    auto.deplacer
		    buche.deplacer
		    tortue.deplacer
		    contenir_Voitures
		    contenir_Buches
		    contenir_Tortues
		    joueur.bouger
		    contenir_frogger
		    --voiture_test
		    create l_couleur.make_rgb (0, 0, 255)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (auto.x, auto.y, auto.longeur, auto.largeur)
		    --buche_test
		    create l_couleur.make_rgb (170, 42, 42)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (buche.x, buche.y, buche.longeur, buche.largeur)
		    --Tortue_test
		    if tortue.etat then
		        create l_couleur.make_rgb (0, 255, 150)
		    else
		    	create l_couleur.make_rgb (150, 255, 0)
		    end
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (tortue.x, tortue.y, tortue.longeur, tortue.largeur)
		    --Joueur_test
		    create l_couleur.make_rgb (0, 255, 0)
		    fenetre.renderer.drawing_color :=l_couleur
		    fenetre.renderer.draw_filled_rectangle (joueur.x, joueur.y, joueur.longeur, joueur.largeur)
		    fenetre.renderer.present
		    --TODO: faire une fonction pour contenir les `ELEMENTS_MOBILE'
		    --TODO: faire une fonction pour détecter les colision du `JOUEUR'
		    --TODO: faire une génération des différents éléments

		end

	contenir_Voitures
		--Permet de contenir la voiture dans la zone de jeux
		do
		    if auto.x > taille_fenetre_x then
		        auto.set_x_spawn(taille_fenetre_x)
		    elseif auto.x < 0-auto.longeur then
		    	auto.set_x_spawn(taille_fenetre_x)
		    end
		end


	contenir_Tortues
		--Permet de contenir la tortue dans la zone de jeux
		do
		    if tortue.x > taille_fenetre_x then
		        tortue.set_x_spawn(taille_fenetre_x)
		    elseif tortue.x < 0-tortue.longeur then
		    	tortue.set_x_spawn(taille_fenetre_x)
		    end
		end

	contenir_Buches
		--Permet de contenir la buche dans la zone de jeux
		do
		    if buche.x > taille_fenetre_x then
		        buche.set_x_spawn(taille_fenetre_x)
		    elseif buche.x < 0-buche.longeur then
		    	buche.set_x_spawn(taille_fenetre_x)
		    end
		end

	contenir_frogger
		--fonction qui permet de contenir le joueur dans la zone de jeux
		do
		    if joueur.x > taille_fenetre_x-joueur.largeur then
		    	--si le joueur vas trop a droite on le rammène dans la zone
		    	joueur.set_x(taille_fenetre_x-joueur.largeur)
		    elseif joueur.x < 0 then
		    	--si le joueur vas trop a gauche on le rammème a au bord
		        joueur.set_x(0)
		    elseif joueur.y < zone_minimal_y then
		    	joueur.set_y(zone_minimal_y)
		    elseif joueur.y > zone_maximal_y then
		    	joueur.set_y(zone_maximal_y)
		    end
		end





--- depuis l'exemple « anime surfaced» écrit par Louis Marchant


on_key_pressed(a_timestamp: NATURAL_32; a_key_event: GAME_KEY_EVENT)
			-- Action when a keyboard key has been pushed
		do
			if not a_key_event.is_repeat then		-- Be sure that the event is not only an automatic repetition of the key
				if a_key_event.is_right then
					--maryo.go_right(a_timestamp)
					joueur.bouger_droite
				elseif a_key_event.is_left then
					--maryo.go_left(a_timestamp)
					joueur.bouger_gauche
				elseif a_key_event.is_up then
				    joueur.bouger_haut
				elseif a_key_event.is_down then
					joueur.bouger_bas
				end
			end

		end

	on_key_released(a_timestamp: NATURAL_32; a_key_event: GAME_KEY_EVENT)
			-- Action when a keyboard key has been released
		do
			if not a_key_event.is_repeat then		-- I don't know if a key release can repeat, but you never know...
				if a_key_event.is_right then
					--maryo.stop_right
				elseif a_key_event.is_left then
					--maryo.stop_left
				end
			end
		end

	on_quit(a_timestamp:NATURAL)
		-- Lorsque l'utilisateur quitte le program
		do
		    game_library.stop --on envoie un signale de fermeture de l'application
		end


end
