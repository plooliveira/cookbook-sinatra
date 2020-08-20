require 'open-uri'
require 'nokogiri'

class Scrapper
  def initialize(search)
    @search = search
  end

  def call
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@search}"
    html = open(url).read
    doc = Nokogiri::HTML(html, nil, 'utf-8')
    push_recipes(doc)
  end

  private

  def push_recipes(doc)
    recipes_finded = []
    doc.search('.node-teaser-item').each_with_index do |element, index|
      new_recipe = {}
      new_recipe[:name] = element.search('.teaser-item__title').text.strip
      new_recipe[:desc] = element.search('.field-item').text.strip
      new_recipe[:time] = element.search('.teaser-item__info-item--total-time').text.strip
      new_recipe[:dif] = element.search('.teaser-item__info-item--skill-level').text.strip
      recipes_finded << Recipe.new(new_recipe) if index < 5
    end
    recipes_finded
  end
end
