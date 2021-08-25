# frozen_string_literal: true

class Scrape
  TIMEOUT_SEC = 3
  class << self
    def mechanize_agent
      agent = Mechanize.new
      agent.user_agent_alias = "Windows Chrome"
      agent.open_timeout = TIMEOUT_SEC
      agent.read_timeout = TIMEOUT_SEC
      agent
    end

    def access_page(agent, url)
      agent.get(url)
    end

    def fetch_title(page)
      page.title || "No Title"
    end

    def fetch_og_image(page)
      og_image = page.at('meta[property="og:image"]')
      og_image ? og_image[:content] : "no_image.svg"
    end
  end
end
