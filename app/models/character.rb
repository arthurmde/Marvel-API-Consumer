class Character < ActiveRecord::Base
  attr_accessible :character_id, :name, :thumbnail, :description, :events_uri

  # def initialize(args)
  #   args.each do |key, value|
  #     instance_variable_set("@#{key}", value)
  #   end
  # end

  # def self.find_all
  #   characters = []
  #   results = Marvel.all_characters
  #   results.each do |result|
  #     thumbnail = result['thumbnail']
  #     thumbnail = thumbnail.blank? ? "" : thumbnail['path']
  #     characters << Character.new(character_id: result['id'],
  #                    name: result['name'],
  #                    thumbnail: thumbnail,
  #                    description: result['description'])
  #   end
  #   characters
  # end

  # def self.find(id)
  #   results = Marvel.character(id)
  #   puts "RESPONSE DATA RESULTS: #{results}"
  #   Character.new(
  #     character_id: results['id'],
  #     name: results['name'],
  #     thumbnail: results['thumbnail']['path'],
  #     description: results['description']
  #   )
  # end
end
