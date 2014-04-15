class Comic 
  attr_accessor :title, :description, :thumbnail, :url

  def initialize(args)
    args.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def self.find_all
    results = Marvel.all_comics
    puts results
    comics = []
    results.each do |result|
      if result['images'].length > 0
        comics << Comic.new(
          title: result['title'],
          description: result['description'],
          thumbnail: result['images'][0]['path'],
          url: result['urls'][0]['url']
        )
      else
        comics << Comic.new(
        title: result['title'],
        description: result['description'],
        thumbnail: result['thumbnail']['path'],
        url: result['urls'][0]['url']        
        )
      end
    end
    comics
  end

  def self.find(id)
    results = Marvel.comic(id)
    Comic.new(
      title: results['title'],
      description: results['description'],
      thumbnail: results['thumbnail']['path'],
      url: results['urls'][0]['url']
    )
  end
end
