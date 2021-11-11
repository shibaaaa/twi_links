# frozen_string_literal: true

require "rails_helper"

RSpec.describe Scrape, type: :model do
  describe "#fetch_title" do
    it "URLからタイトルを取得できること" do
      crawler = Scrape.new
      page = crawler.access_page("http://example.com/")
      expect(crawler.fetch_title(page)).to eq "Example Domain"
    end
  end

  describe "#fetch_og_image" do
    context "任意のページにog:imageタグが存在するとき" do
      it "og:imageタグの要素を取得できること" do
        crawler = Scrape.new
        page = crawler.access_page("https://shibaaa647.hatenablog.com/")
        expect(crawler.fetch_og_image(page)).to eq "https://cdn.blog.st-hatena.com/images/theme/og-image-1500.png"
      end
    end

    context "任意のページにog:imageタグが存在しないとき" do
      it "'no_image.svg'が返ること" do
        crawler = Scrape.new
        page = crawler.access_page("http://example.com/")
        expect(crawler.fetch_og_image(page)).to eq "no_image.svg"
      end
    end
  end
end
