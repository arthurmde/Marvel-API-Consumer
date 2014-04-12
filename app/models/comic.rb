class Comic 
  attr_accessor :title, :description, :thumbnail, :url

  def initialize(args)
    args.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def self.find(id)
    results = Marvel.comic(id)
    puts results
    Comic.new(
      title: results['title'],
      description: results['description'],
      thumbnail: results['thumbnail']['path'],
      url: results['urls'][0]['url']
    )
  end
end
