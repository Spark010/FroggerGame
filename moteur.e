note
	description: "Moteur du jeux"
	author: "Francis Croteau"
	date: "2020-02-22"
	revision: "$2020-05-15"

class
	MOTEUR
inherit
    GAME_LIBRARY_SHARED

create
	make
feature --Attributs
	--attributs de la classe Moteur
	taille_fenetre_x:INTEGER_32
	--taille de la fênetre en pixel sur l'axe horizontale
	taille_fenetre_y:INTEGER_32
	--taille de la fênetre en pixel sur l'axe verticale
	zone_maximal_y:INTEGER_32
	--position vertical maximal (dans le bas de la fênetre) de la zone de jeux (utiliser pour contenir le joueur)
	zone_minimal_y:INTEGER_32
	--position verticale mininal (dans le haut de la fênetre) de la zone de jeux (utiliser pour contenir le joueur)
	route: LIST[VOITURES]
	--liste d'objet sur la route (inclus les voutures, cammions)
	riviere1:LIST[BUCHES]
	--liste d'objets sur la rivière partie bûches
	joueur:JOUEUR
	--objet du joueur (la grenouille)
	riviere2:LIST[TORTUES]
	--liste des objets tortues sur la rivière
 	paysage:PAYSAGE --fond d'écrant du jeux


feature {NONE} -- Initialisation
	make
			-- Initialise `Curent'

		local
			l_builder:GAME_WINDOW_RENDERED_BUILDER
			l_color:GAME_COLOR
		do
			--on assigne la valeur de la fenêtre. on simule une borne d'arcade a une resolution légèrement modifier
			taille_fenetre_x:=300
		    taille_fenetre_y:=330
		    zone_minimal_y:=90
		    zone_maximal_y:=270
			--création de la fênetre avec rendue sycroniser
			create l_builder
		    l_builder.set_dimension (taille_fenetre_x, taille_fenetre_y)
		    l_builder.set_title ("Frogger")
		    l_builder.enable_must_renderer_synchronize_update
		    fenetre := l_builder.generate_window
		    --création d'objet spécifique au jeux
		    create paysage.make (fenetre.renderer) --crée le rendu du fond de la fênetre
		    create joueur.make("frogger", fenetre.renderer)
		    route := populer_route(fenetre.renderer)
		    riviere1 := populer_buches(fenetre.renderer)
		    riviere2 := populer_tortues(fenetre.renderer)
		end

feature --Acces

	lancer
			--Démare le programme
		do
			--on lance les agents
			game_library.quit_signal_actions.extend (agent on_quit)
			game_library.iteration_actions.extend (agent on_interation)
			fenetre.key_pressed_actions.extend (agent on_key_pressed)
			fenetre.key_released_actions.extend (agent on_key_released)
			--si on supporte l'accélération graphique on lance le jeux dans ce mode sinon on utilise le de dessin logiciel
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

		do
			--dessiner_scene
			--rendue de la scène
			fenetre.renderer.draw_texture (paysage, 0, 0)
			--on déplace et restrein tout dans la zone de jeux
			deplacer_tout
			contenir_tout
			--on redessine les objets
			dessiner_objets
		    fenetre.renderer.present
		    --fenetre.surface.draw_surface (texte_surface, 300, 315)

		end

	deplacer_tout
		--fonction qui parcour les listes pour déplacer chaque objet.
		do
		    across route as vehicule loop
		    	vehicule.item.deplacer
		    end
		    across riviere1 as buche loop
		    	buche.item.deplacer
		    end
		    across riviere2 as tortue loop
		        tortue.item.deplacer(fenetre.renderer)
		    end
		    joueur.bouger
		end

	contenir_tout
		--fait appelle aux fonctions des objets pour les contenir dans la zone de jeux
		do
		    contenir_Voitures
		    contenir_Buches
		    contenir_Tortues
		    contenir_joueur
		end

	dessiner_objets
		local
		    l_couleur:GAME_COLOR
		do
			--la rue
			across route as vehicule loop
		    	fenetre.renderer.draw_texture(vehicule.item, vehicule.item.x, vehicule.item.y)
		    end
		    --la rivière1 (les bûches)
		    across riviere1 as buche loop
		    	fenetre.renderer.draw_texture(buche.item, buche.item.x, buche.item.y)
		    end
		    --la rivière2 (les tortues)
		    across riviere2 as tortue loop
		    	fenetre.renderer.draw_texture(tortue.item, tortue.item.x, tortue.item.y)
		    end
		    fenetre.renderer.draw_texture(joueur, joueur.x, joueur.y)
		    create l_couleur.make_rgb (0, 255, 0)
		    fenetre.renderer.drawing_color := l_couleur
		    fenetre.renderer.draw_filled_rectangle (150-joueur.barre_temps, 315, joueur.barre_temps, 15)
		end

	contenir_Voitures
		--Permet de contenir la voiture dans la zone de jeux
		do
			across route as vehicule loop
				--pour chaque véhicule sur la route si un véhicule ressort par la droite on le remet a gauche
				-- on fait l'inverse si le véhicule est de l'autre coté
		    	if vehicule.item.x > taille_fenetre_x then
		       	 vehicule.item.set_x_spawn(taille_fenetre_x)
		    	elseif vehicule.item.x < 0-vehicule.item.longeur then
		    		vehicule.item.set_x_spawn(taille_fenetre_x)
		   		end
		   	end
		end


	contenir_Tortues
		--Permet de contenir la tortue dans la zone de jeux
		do
			across riviere2 as tortue loop
		    	if tortue.item.x > taille_fenetre_x then
		        	tortue.item.set_x_spawn(taille_fenetre_x)
		    	elseif tortue.item.x < 0-tortue.item.longeur then
		    		tortue.item.set_x_spawn(taille_fenetre_x)
		    	end
		    end
		end

	contenir_Buches
		--Permet de contenir la buche dans la zone de jeux
		do
			across riviere1 as buche loop
		    	if buche.item.x > taille_fenetre_x then
		       		buche.item.set_x_spawn(taille_fenetre_x)
		    	elseif buche.item.x < 0-buche.item.longeur then
		    		buche.item.set_x_spawn(taille_fenetre_x)
		    	end
		    end
		end

	contenir_joueur
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


    populer_route(a_renderer:GAME_RENDERER):LIST[VOITURES]
    	--fonction qui génère les véhicules dans la rue
    	--//TODO: creer méthode de calcul random pour la position plus un random avec range
    	local
    		l_i:INTEGER_32
    		l_auto:VOITURES --utiliser pour la génération
    		-- compteur d'itération pour les boucles
    	do
    	    create {ARRAYED_LIST[VOITURES]}route.make (18)
    		--voitures 255,240,225,210
    		from
    			l_i:=3
    		until
    		    l_i=-1
    		loop
    		    --create l_auto.make_default (l_i*27+30+30*l_i, 255, FALSE, FALSE, fenetre.renderer)
    		    --route.extend(l_auto)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=4
    		until
    			l_i=-1
    		loop
    		    create l_auto.make_default (l_i*27+30*l_i+90, 240, FALSE, FALSE, fenetre.renderer)
    		    route.extend(l_auto)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=4
    		until
    		    l_i=-1
    		loop
    		    create l_auto.make_default (l_i*27+30*l_i+60, 225, FALSE, FALSE, fenetre.renderer)
    		    route.extend(l_auto)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=4
    		until
    			l_i=-1
    		loop
    		    create l_auto.make_default (l_i*27+30*l_i+30, 210, TRUE, FALSE, fenetre.renderer)
    		    route.extend(l_auto)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=3
    		until
    		    l_i=-1
    		loop
    		    create l_auto.make_default (l_i*55+90*l_i+60, 195, FALSE, TRUE, fenetre.renderer)
    		    route.extend(l_auto)
    		    l_i:=l_i-1
    		end
    		RESULT := route
		end


    populer_buches(a_renderer:GAME_RENDERER):LIST[BUCHES]
    	--fonction qui génère les buches dans la rue
    	--//TODO: creer méthode de calcul random pour la position plus un random avec range
    	local
    		l_i:INTEGER_32
    		l_tron:BUCHES --utiliser pour la génération
    		-- compteur d'itération pour les boucles

    	do
    	    create {ARRAYED_LIST[BUCHES]}riviere1.make (18)
    		--buche 150,135, 105
			--=> fast
			--=>slow
			--1 ligne buche => 105
    		from
    			l_i:=1
    		until
    		    l_i=-2
    		loop
    		    create l_tron.make_defaut(188*l_i+34, 150, false, true, TRUE, fenetre.renderer)
    		    riviere1.extend(l_tron)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=2
    		until
    			l_i=-1
    		loop
    		    create l_tron.make_defaut(66*l_i+55, 135, true, false, TRUE, fenetre.renderer)
    		    riviere1.extend(l_tron)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=3
    		until
    		    l_i=-1
    		loop
    		    create l_tron.make_defaut(76*l_i+88, 105, false, false, TRUE, fenetre.renderer)
    		    riviere1.extend(l_tron)
    		    l_i:=l_i-1
    		end
    		RESULT := riviere1
		end

	populer_tortues(a_renderer:GAME_RENDERER):LIST[TORTUES]
    	--fonction qui génère les buches dans la rue
    	--tortue 165,120
    	--//TODO: creer méthode de calcul random pour la position plus un random avec range
    	local
    		l_i:INTEGER_32
    		l_tortue:TORTUES --utiliser pour la génération
    		-- compteur d'itération pour les boucles

    	do
    	    create {ARRAYED_LIST[TORTUES]}riviere2.make (18)
    		--tortue 165,120
    		from
    			l_i:=1
    		until
    		    l_i=-2
    		loop
    		    create l_tortue.make (48*l_i+13, 165, FALSE, fenetre.renderer)
    		    riviere2.extend(l_tortue)
    		    l_i:=l_i-1
    		end
    		from
    			l_i:=2
    		until
    			l_i=-1
    		loop
    		    create l_tortue.make (87*l_i+56, 120, FALSE, fenetre.renderer)
    		    riviere2.extend(l_tortue)
    		    l_i:=l_i-1
    		end
    		RESULT := riviere2
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
					--//TODO
				elseif a_key_event.is_left then
					--//TODO
				end
			end
		end

	on_quit(a_timestamp:NATURAL)
		-- Lorsque l'utilisateur quitte le program
		do
		    game_library.stop --on envoie un signale de fermeture de l'application
		end


end
