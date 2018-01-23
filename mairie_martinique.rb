require "google_drive"
require 'rubygems'
require 'nokogiri'
require 'open-uri'




def get_the_email_of_a_townhal_from_its_webpage(url)
    page = Nokogiri::HTML(open(url))
    table_catch = page.xpath('//html/body/table/tr[3]/td/table/tr[1]/td[1]/table[4]/tr[2]/td/table/tr[4]/td[2]/p')
    table_catch.each do |elem|
        return elem.text
    end
end

def get_all_the_urls_of_martinique_townhalls(url)
    page = Nokogiri::HTML(open(url))
    table= []
    url_catch = page.css("td p a").css(".lientxt")
    url_catch.each  do |city|
        relative_url = "http://annuaire-des-mairies.com" + city['href'][1..-1]
        hashing = Hash.new

        hashing["city_name"] = city.text
        hashing["city_email"] = get_the_email_of_a_townhal_from_its_webpage(relative_url)
        table << hashing
        # puts hashing
        # puts table
    end
    return table
end
#get_all_the_urls_of_martinique_townhalls(PAGE_URL)




def fill_spreadsheet()

  session = GoogleDrive::Session.from_config("config.json")

  ws = session.spreadsheet_by_key("1FCqthnXWZwYMhPXYxgW9DyGH15dItGXtWpgV-5CYKUs").worksheets[0]

  ws.reload

  infos = get_all_the_urls_of_martinique_townhalls("http://annuaire-des-mairies.com/martinique.html")


  ws[1, 1] = "Nom des villes"   # set up le nom de la col 1
  ws[1, 2] = "Email des mairies"  # set up le nom de la col 2
  i = 2  # initialiser i(ligne) à 2

  infos.each do |element|   # itérer sur chaque element (qui sont des hash) du tableau
    ws[i, 1] = element["city_name"]    # a la ligne 2 col 1 on veut stokcer le city_name
    ws[i, 2] = element["city_email"] #  idem pour col 2 et city_email
    i += 1  # indiquer le changement de ligne
  end
  (1..ws.num_rows).each do |row|   # pour chaque ligne débutant de 1 à ...
    (1..ws.num_cols).each do |col|   # pour chaque col débutant de 1 à ...
      p ws[row, col]   # afficher
    end
  end

  ws.save

end

fill_spreadsheet()
