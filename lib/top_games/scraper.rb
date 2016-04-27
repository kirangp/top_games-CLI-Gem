class TopGames::Scraper

    attr_accessor :name, :url, :meta_score, :summary

    def initialize(name = nil, url = nil)
      @name = name
      @url = url
    end

    def self.all
      @@all ||= scrape_top_games
    end

    def self.summary
      @summary ||= scrape_game_page.search("")
    end




    def self.scrape_top_games
      page = Nokogiri::HTML(open("http://www.metacritic.com/browse/games/score/metascore/all/pc/filtered?sort=desc", "User-Agent" => "Mozilla/5.0 (Windows NT 6.0; rv:12.0) Gecko/20100101 Firefox/12.0 FirePHP/0.7.1"))

      top10list = page.css("div.product_title a")[0..9]
      top10list.collect{|e| new(e.text.split.join(" "), "www.metacritic.com#{e.attr("href")}")}
    #  binding.pry
    end

    def self.scrape_game_page
      @game_page = Nokogiri::HTML(open(self.url))
    end




          # count = 0
          # puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
          # puts ""
          # # while count < 10
          #
          #   number = page.css("div.product_item.row_num")[count].text.strip
          #   score = page.css("div.metascore_w.small.game.positive")[count].text.strip
          #   name = page.search("div.product_item.product_title a")[0..9]
          #   #user_rating = page.css("span.data.textscore.textscore_outstanding")[0..9].text.strip
          #   release = page.css("div.product_item.product_date")[count].text.strip
          #
          #   count+=1
          #   binding.pry
          #
          #   name = page.search("div.product_item.row_num div.metascore_w.small.game.positive")
          #
          #   puts "#{number}   #{name}         Score => #{score}         Release => #{release}"
          # # end
          # puts ""
          # puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
end
