class Marvel
  include HTTParty

  base_uri 'gateway.marvel.com:80'

  def self.character(id)
    response = 
        self.get("/v1/public/characters/#{id}?#{MarvelParameters.credentials}")
    response_body = JSON.parse(response.body)
    results = response_body['data']['results'][0]    
  end

  def self.import_characters
    characters = Marvel.characters_list
    Character.destroy_all

    characters.each do |key, value|
      response = self.get("/v1/public/characters/#{key.to_s}?&#{MarvelParameters.credentials}")
      response_body = JSON.parse(response.body)
      results = response_body['data']['results']
      
      results.each do |result|
        character = Character.new

        thumbnail = result['thumbnail']
        character.thumbnail = thumbnail.blank? ? "" : thumbnail['path']
        character.character_id = result['id']
        character.name = result['name']
        character.description = result['description']
        character.events_uri = result['events']['collectionURI']

        character.save!

         puts "="*100, Character.last.inspect, "="*100
      end
    end
  end

  def self.all_characters
    response = self.get("/v1/public/characters?nameStartsWith=z&orderBy=name&limit=99&offset=0&#{MarvelParameters.credentials}")
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

  private

  def self.characters_list
    characters = Hash.new

    characters[1017100] = "A-Bomb (HAS)"
    characters[1009146] = "Abomination"
    characters[1009148] = "Absorbing Man"
    characters[1010354] = "Adam Warlock"
    characters[1009497] = "Alexander Pierce"
    characters[1009152] = "Ancient One"
    characters[1011396] = "Angel"
    characters[1010802] = "Ant-Man (Eric O'Grady)"
    characters[1010801] = "Ant-Man (Scott Lang)"
    characters[1009156] = "Apocalypse"
    characters[1010773] = "Arachne"
    characters[1010784] = "Ares"
    characters[1009740] = "Arnim Zola"

    characters[1009169] = "Baron Strucker"
    characters[1009170] = "Baron Zemo (Heinrich Zemo)"
    characters[1010906] = "Baron Zemo (Helmut Zemo)"
    characters[1009172] = "Batroc the Leaper"
    characters[1009175] = "Beast"
    characters[1009180] = "Beta-Ray Bill"
    characters[1009182] = "Bishop"
    characters[1009183] = "Black Bird"
    characters[1009184] = "Black Bolt"
    characters[1009185] = "Black Cat"
    characters[1009187] = "Black Panther"
    characters[1009189] = "Black Widow"
    characters[1009190] = "Blackheart"
    characters[1009191] = "Blade"
    characters[1009195] = "Blastaar"
    characters[1010830] = "Blazing Skull"
    characters[1009199] = "Blob"
    characters[1009167] = "Bruce Banner"
    characters[1009211] = "Bucky"
    characters[1009212] = "Bullseye"
    
    characters[1009214] = "Cable"
    characters[1009220] = "Captain America"
    characters[1010338] = "Captain Marvel (Carol Danvers)"
    characters[1009224] = "Captain Marvel (Mar-Vell)"
    characters[1011027] = "Captain Universe"
    characters[1009733] = "Charles Xavier"
    characters[1009241] = "Cloak"
    characters[1009243] = "Colossus"
    characters[1009252] = "Crossbones"
    characters[1009257] = "Cyclops"

    characters[1010776] = "Danny Rand"
    characters[1009262] = "Daredevil"
    characters[1009265] = "Dark Phoenix"
    characters[1009268] = "Deadpool"
    characters[1009269] = "Death"
    characters[1010890] = "Deathlok"
    characters[1009281] = "Doctor Doom"
    characters[1009276] = "Doctor Octopus"
    characters[1009282] = "Doctor Strange"
    characters[1010677] = "Dracula"
    characters[1010735] = "Drax"

    characters[1009287] = "Electro"
    characters[1009288] = "Elektra"
    characters[1009310] = "Emma Frost"

    characters[1009297] = "Falcon"

    characters[1009312] = "Galactus"
    characters[1009313] = "Gambit"
    characters[1010763] = "Gamora"
    characters[1010925] = "Ghost Rider (Daniel Ketch"
    characters[1009320] = "Giant Man"
    characters[1009321] = "Gladiator (Kallark)"
    characters[1014985] = "Green Goblin (Barry Norman Osborn)"
    characters[1010928] = "Green Goblin (Harry Osborn)"
    characters[1010743] = "Groot"
    characters[1009619] = "Gwen Stacy"

    characters[1011490] = "Hank Pym"
    characters[1009338] = "Hawkeye"
    characters[1009343] = "Hercules"
    characters[1010930] = "Hobgoblin (Jason Macendale)"
    characters[1010373] = "Howard The Duck"
    characters[1009351] = "Hulk"
    characters[1009356] = "Human Torch"

    characters[1009362] = "Iceman"
    characters[1009366] = "Invisible Woman"
    characters[1010888] = "Iron Fist (Orson Randall)"
    characters[1009368] = "Iron Man"
    characters[1009371] = "Iron Monger"
    characters[1009487] = "Iron Patriot"

    characters[1009372] = "J. Jonah Jameson"
    characters[1009496] = "Jean Grey"
    characters[1009382] = "Juggernaut"

    characters[1009384] = "Kang"
    characters[1009389] = "Kingpin"
    characters[1010842] = "King Cobra"
    characters[1011147] = "Korath"
    characters[1011080] = "Korg"
    characters[1011312] = "Korvac"
    characters[1009391] = "Kraven the Hunter"

    characters[1009398] = "Leader"
    characters[1009404] = "Lizard"
    characters[1010363] = "Logan"
    characters[1009407] = "Loki"
    characters[1009215] = "Luke Cage"

    characters[1010726] = "M.O.D.O.K."
    characters[1010796] = "Madame Web (Julia Carpenter)"
    characters[1009413] = "Madrox"
    characters[1011328] = "Maestro"
    characters[1009417] = "Magneto"
    characters[1009421] = "Mandarin"
    characters[1011335] = "Maria Hill"
    characters[1009708] = "Mary Jane Watson"
    characters[1009440] = "Mephisto"
    characters[1010681] = "Mercury"
    characters[1011019] = "Molecule Man"
    characters[1009452] = "Moon Knight"
    characters[1009454] = "Morbius"
    characters[1009459] = "Mr. Fantastic"
    characters[1009464] = "Mysterio"
    characters[1009465] = "Mystique"

    characters[1009466] = "Namor"
    characters[1010365] = "Nebula"
    characters[1009471] = "Nick Fury"
    characters[1009472] = "Nightcrawler"
    characters[1010063] = "Norrin Radd"
    characters[1009477] = "Nova"

    characters[1009480] = "Odin"
    characters[1009482] = "Omega Red"
    characters[1009483] = "Onslaught"

    characters[1009491] = "Peter Parker"
    characters[1009504] = "Professor X"
    characters[1009505] = "Proteus"
    characters[1010865] = "Puff Adder"
    characters[1009515] = "Punisher"

    characters[1009524] = "Quicksilver"

    characters[1011360] = "Red Hulk"
    characters[1009535] = "Red Skull"
    characters[1009537] = "Rhino"
    characters[1010744] = "Rocket Raccoon"
    characters[1009546] = "Rogue"
    characters[1010344] = "Ronan"
    characters[1009551] = "Russian"

    characters[1009554] = "Sabretooth"
    characters[1009558] = "Sandman"
    characters[1009562] = "Scarlet Witch"
    characters[1009570] = "Sentinel"
    characters[1009574] = "Shadowcat"
    characters[1009592] = "Silver Surfer"
    characters[1011223] = "Skaar"
    characters[1009610] = "Spider-Man"
    characters[1010733] = "Star-Lord (Peter Quill)"
    characters[1010326] = "Steve Rogers"
    characters[1009629] = "Storm"

    characters[1009644] = "T'Challa"
    characters[1009648] = "Taskmaster"
    characters[1009651] = "Terrax"
    characters[1009652] = "Thanos"
    characters[1009662] = "Thing"
    characters[1009664] = "Thor"
    characters[1009624] = "Tony Stark"

    characters[1009685] = "Ultron"

    characters[1009663] = "Venom (Flash Thompson)"
    characters[1010788] = "Venom (Mac Gargan)"
    characters[1009697] = "Vision"
   
    characters[1009711] = "Whiplash (Mark Scarlotti)"
    characters[1010740] = "Winter Soldier"
    characters[1009718] = "Wolverine"

    characters
  end
end
