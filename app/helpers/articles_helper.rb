# frozen_string_literal: true

module ArticlesHelper
  def ogp_title(target_url)
    article_page(target_url).title
  end

  def ogp_image(target_url)
    article_page(target_url).at('meta[property="og:image"]')[:content]
  end

  def ogp_description(target_url)
    article_page(target_url).at('meta[property="og:description"]')[:content]
  end

  private
    def article_page(target_url)
      agent = Mechanize.new
      agent.user_agent_alias = "Windows Mozilla"
      agent.get(target_url)
    end
end
