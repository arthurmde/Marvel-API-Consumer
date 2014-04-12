class Character
  attr_accessor :character_id, :name, :thumbnail, :description

  def initialize(args)
    args.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
  
  def self.find_all
    characters = []
    results = Marvel.all_characters
    results.each do |result|
      characters << Character.new(character_id: result['id'],
                     name: result['name'],
                     thumbnail: result['thumbnail']['path'],
                     description: result['description'])
    end
    characters
  end

  def self.find(id)
    results = Marvel.character(id)
    puts "RESPONSE DATA RESULTS: #{results}"
    Character.new(
      character_id: results['id'],
      name: results['name'],
      thumbnail: results['thumbnail']['path'],
      description: results['description']
    )
  end
end
