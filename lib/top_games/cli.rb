
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
        binding.pry
        #  TopGames::Scraper.scrape_top_games
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
                #  binding.pry
                puts '--        --        --        --        --        --        --        --'
                puts
                puts '--        --        --        --        --        --        --        --'
                puts

            end
        end
        puts 'Happy gaming and goodbye'
    end
end
