class TopGames::Scraper
    attr_accessor :name, :url, :meta_score, :summary, :developer, :release, :user_score

    def initialize(name = nil, url = nil)
        @name = name
        @url = url
    end

    def self.all
        @@all ||= scrape_top_games
    end

    def self.game_object(i)
        all[i - 1]
    end

    def summary
        sleep(0.5)
        @summary ||= scrape_game_page.search("span[itemprop='description']").text.strip
    end

    def meta_score
        sleep(0.5)
        @meta_score ||= scrape_game_page.search("span[itemprop='ratingValue']").text.strip
    end

    def developer
        sleep(0.5)
        @developer ||= scrape_game_page.search('li.summary_detail.developer span.data').text.strip
    end

    def release
        sleep(0.5)
        @release ||= scrape_game_page.search("span[itemprop='datePublished']").text.strip
    end

    def user_score
        sleep(0.5)
        @user_score ||= scrape_game_page.search('a.metascore_anchor div.metascore_w.user').text.strip
    end

    def self.scrape_top_games
        page = Nokogiri::HTML(open('http://www.metacritic.com/browse/games/score/metascore/all/pc/filtered?sort=desc', 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.0; rv:12.0) Gecko/20100101 Firefox/12.0 FirePHP/0.7.1'))

        top10list = page.css('div.product_title a')[0..9]
        top10list.collect { |e| new(e.text.split.join(' '), "www.metacritic.com#{e.attr('href')}") }
    end

    def scrape_game_page
        @game_page ||= Nokogiri::HTML(open("http://#{url}", 'User-Agent' => 'Mozilla/5.0 (Windows NT 6.0; rv:12.0) Gecko/20100101 Firefox/12.0 FirePHP/0.7.1'))
    end
end
