class Character < ActiveRecord::Base
  
  def self.find_all
    characters = []
    results = Marvel.all_characters
    results.each do |result|
      characters << Character.find_or_create_by(character_id: result['id'],
                     name: result['name'],
                     thumbnail: result['thumbnail']['path'],
                     description: result['description'])
    end
    characters
  end

  def self.find(id)
    results = Marvel.character(id)
    puts "RESPONSE DATA RESULTS: #{results}"
    Character.find_or_create_by(character_id: results['id'],
       name: results['name'],
       thumbnail: results['thumbnail']['path'],
       description: results['description'])
  end
end
