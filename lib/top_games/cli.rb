
class TopGames::CLI
    def call
        start
    end

    def list_games
        puts ''
        puts 'Displays the top 10 PC games from Metacritic arranged by rating'
        puts ''
        TopGames::Scraper.all.each.with_index(1) do |game, i|
            puts "#{i}. #{game.name}"
        end
        puts ''
    end

    def start
        list_games
        input = nil
        while input != 'exit'
            puts ''
            puts 'Please press any number between 1 - 10 to get more information about the games.'
            puts ''
            puts 'Type exit to quit the program'
            puts 'Type list to list games'
            puts ''
            input = gets.strip.downcase
            if input == 'list'
                list_games
            elsif input.to_i.between?(1, 10)
                game = TopGames::Scraper.game_object(input.to_i)
                game_details(game)
            end
        end
        puts 'Happy gaming and goodbye'
    end

    def game_details(game)
        puts ''
        puts "-------------- #{game.name} --------------"

        puts ''
        puts "Metascore => #{game.meta_score}  "
        puts ''

        puts ''
        puts "User Score => #{game.user_score}  "
        puts ''

        puts ''
        puts "Developer => #{game.developer}  "
        puts ''

        puts ''
        puts "Release => #{game.release}  "
        puts ''

        puts ''
        puts game.summary
        puts ''
    end
end
