class CLI
  attr_accessor :songs,
                :menu_color, :welcome_color, :title_color, :field_color,:error_color,
                :prev_menu_msg,:quit_msg

  def initialize()
    @error_color=:red
    @menu_color=:green
    @welcome_color=:yellow
    @title_color=:blue
    @field_color=:light_blue
    @prev_menu_msg = "Or enter 'r' to return to the main menu.".colorize(@menu_color)
    @quit_msg = "To quit, type 'e'.".colorize(@menu_color)
  end

  def run
    #system('clear') # clears terminal
    welcome
    menu
  end

  def welcome
    puts "Welcome to Media Hub!".colorize(@welcome_color)
    main_menu_options
  end

  def main_menu_options
    puts "To list all media (movies, shows, songs) , enter '1'.".colorize(@menu_color)
    puts "To search for a show, enter '2'.".colorize(@menu_color)
    puts "To search people, enter '3'.".colorize(@menu_color)
    puts "To quit, type 'e'.".colorize(@menu_color)
    puts "What would you like to do?".colorize(@menu_color)
    main_menu_input
  end

  def main_menu_input
    user_input = gets.strip
    evaluate_main_menu_input(user_input)
  end

  def evaluate_main_menu_input(user_input)
    if user_input == "1"
      puts "Listing all media is a feature available to paid subscribers".colorize(@error_color)
      #list_media
    elsif user_input == "2"
      search_shows
    elsif user_input == "3"
      puts "Searching people/cast is a feature available to paid subscribers".colorize(@error_color)
      #search_people
    elsif user_input == "e"
      goodbye
    else
      incorrect_input(user_input)
    end
    main_menu_options
  end

  def search_shows
    puts "Please enter the name of a show:"
    user_input = gets.strip
    @shows = API.fetch_show(user_input)
    puts "The search for #{user_input} returned #{@shows.length} results."
    if @shows!=nil
      shows_sub_menu
    end
    main_menu_options
  end

      def shows_sub_menu
        list_show_results
        shows_sub_menu_options
      end
        def list_show_results
          @shows.each.with_index(1) do |show, index|
            puts "#{index}.".colorize(@menu_color) + " #{show.name}.".colorize(@title_color)
          end
        end

      def shows_sub_menu_options
        puts "Please enter index of the show to learn more about the show.".colorize(@menu_color)
        puts @prev_menu_msg
        puts @quit_msg
        user_input = gets.strip
        isInt = (user_input.to_i.to_s == user_input)
        if user_input == "r"
          main_menu_options
        elsif isInt
          index = user_input.to_i-1
          @show = @shows[index]
          show_sub_menu
        elsif user_input == "e"
          goodbye
        else
          incorrect_input(user_input)
          shows_sub_menu_options
        end
      end

        def show_sub_menu
            puts "#{@show.name}:".colorize(@title_color)+" \n\t Summary:".colorize(@field_color)+ "#{@show.summary}"
            show_sub_menu_options
        end

        def show_sub_menu_options
          puts "Please enter '1' to see the cast of ".colorize(@menu_color) + "#{@show.name}.".colorize(@title_color)
          puts @prev_menu_msg + "with search results listing shows.".colorize(@menu_color)
          puts @quit_msg
          user_input = gets.strip
          isInt = (user_input.to_i.to_s == user_input)
          if user_input == "r"
            shows_sub_menu
          elsif isInt
            display_cast_menu
          elsif user_input == "e"
            goodbye
          else
            incorrect_input(user_input)
            show_sub_menu_options
          end
        end

        def display_cast_menu
           display_cast
           cast_menu_options
        end

          def display_cast
            puts "#{@show.name}.".colorize(@title_color)
            puts "Has the following cast:"
            display_shows_cast
          end

            def display_shows_cast
              @show.cast.each.with_index(1) do |character, index|
                puts "#{index}. #{character.name} played by :".colorize(@field_color)
                character.actors.each.with_index(1) do |actor, i|
                  puts "\t #{index}.#{i}".colorize(@menu_color)+ " : #{actor.name}."
                end
              end
            end

        def cast_menu_options
          puts "Please enter the actor's number to see more about the actor.".colorize(@menu_color)
          puts "Please Enter 'r' to return to the #{@show.name}'s' menu.".colorize(@menu_color)
          puts @quit_msg
          user_input = gets.strip
          isFloat = (user_input.to_f.to_s == user_input)
          if user_input == "r"
            show_sub_menu
          elsif isFloat
            display_actor_menu(user_input)
          elsif user_input == "e"
            goodbye
          else
            incorrect_input(user_input)
            cast_menu_options
          end
        end

  def display_actor_menu(character_actor)
    display_actor(character_actor)
    display_actor_menu_options
  end

      def display_actor(character_actor)
        character_index = character_actor.split(".")[0].to_i-1
        actor_index = character_actor.split(".")[1].to_i-1
        character = @show.cast[character_index]
        actor = character.actors[actor_index]
        display_actor_information(actor)
      end
      def display_actor_menu_options
        puts "Please Enter 'r' to return to the #{@show.name}'s' menu.".colorize(@menu_color)
        puts "Please Enter 'm' to return to the main menu.".colorize(@menu_color)
        puts @quit_msg
        user_input = gets.strip
        if user_input == "r"
          show_sub_menu
        elsif user_input == "m"
          main_menu_options
        elsif user_input == "e"
          goodbye
        else
          incorrect_input(user_input)
          display_actor_menu_options
        end
      end


        def display_actor_information(actor)
          puts "Name :".colorize(@field_color)+ " #{actor.name}"
          puts "Birthday :".colorize(@field_color)+ " #{actor.birthday}"
          puts "Gender : ".colorize(@field_color)+ "#{actor.gender}"
          puts "Country : ".colorize(@field_color)+ "#{actor.country["name"]} , #{actor.country["code"]}, #{actor.country["timezone"]}"
        end

  def search_people
    puts "Please enter the name of the actor:".colorize(@menu_color)
    user_input = gets.strip
    people #= API.fetch_people()
    if people!=nil
      #list_results(people)
    else
      # otherwise go back to "menu" ? with no results for entry
    end
  end

  def goodbye
    d= Date.today
    today = d.strftime("%A")
    puts "Thank you for using the Media Hub, have a happy, happy, joyful, joyful, adorable #{today}!".colorize(@menu_color)
    exit
  end

  def incorrect_input(user_input)
    puts "This menu does not have the option : #{user_input}".colorize(@error_color)
  end


end
