class Marvel
  include HTTParty
  base_uri 'gateway.marvel.com:80'

  def self.character(id)
    response = 
        self.get("/v1/public/characters/#{id}?#{MarvelParameters.credentials}")
    response_body = JSON.parse(response.body)
    results = response_body['data']['results'][0]    
  end

  def self.all_characters
    response = 
        self.get("/v1/public/characters?#{MarvelParameters.credentials}")
    response_body = JSON.parse(response.body)
    results = response_body['data']['results']
  end

  def self.comic(id)
    response = 
        self.get("/v1/public/comics/#{id}?#{MarvelParameters.credentials}")
    response_body = JSON.parse(response.body)
    puts "RESPONSE BODY: #{response_body}"
    results = response_body['data']['results'][0]
  end

  def self.all_comics
    response = 
        self.get("/v1/public/comics?#{MarvelParameters.credentials}")
    response_body = JSON.parse(response.body)
    results = response_body['data']['results']    
  end
end
