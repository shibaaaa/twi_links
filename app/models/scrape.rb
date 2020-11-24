# frozen_string_literal: true

class Scrape
  def initialize(url)
    @url = url
  end

  def access_page
    mechanize_agent.get(@url)
  end

  def fetch_title(page)
    page.title || "No Title"
  rescue => e
    ErrorUtility.log e
    "Not Found"
  end

  def fetch_og_image(page)
    og_image = page.at('meta[property="og:image"]')
    og_image ? og_image[:content] : "no_image.svg"
  rescue => e
    ErrorUtility.log e
    "no_image.svg"
  end

  private
    def mechanize_agent
      agent = Mechanize.new
      agent.user_agent_alias = "Windows Chrome"
      agent
    end
end
