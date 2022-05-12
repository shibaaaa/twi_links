# frozen_string_literal: true

class Scraper
  TIMEOUT_SEC = 3

  class << self
    def access_page(url)
      self.mechanize.get(url)
    end

    def fetch_title(page)
      page.title || "No Title"
    end

    def fetch_og_image(page)
      og_image = page.at('meta[property="og:image"]')
      og_image ? og_image[:content] : "no_image.svg"
    end

    private
      def mechanize
        @mechanize ||= Mechanize.new do |a|
          a.user_agent_alias = "Windows Chrome"
          a.open_timeout     = TIMEOUT_SEC
          a.read_timeout     = TIMEOUT_SEC
        end
      end
  end
end
