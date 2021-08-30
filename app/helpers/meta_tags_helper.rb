# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "TwiLinks",
      reverse: true,
      charset: "utf-8",
      description: "Twitterのいいねからブックマークを作成",
      viewport: "width=device-width, initial-scale=1.0",
      og: {
        title: :title,
        type: "website",
        site_name: "twilinks",
        description: :description,
        image: "",
        url: "https://twilinks.herokuapp.com/"
      }
    }
  end
end
