# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css('li.project.grid_4').each do |p|
    title = p.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      :image_link => p.css('div.project-thumbnail a img').attribute('src').value,
      :description => p.css('p.bbcard_blurb').text,
      :location => p.css('ul li a span.location-name').text,
      :percent_funded => p.css('ul.project-stats li.first.funded strong').text.gsub("%", "").to_i
    }
  end

  
  projects


end


create_project_hash