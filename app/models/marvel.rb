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

    characters.each do |key, value|
      response = self.get("/v1/public/characters/#{key.to_s}?&#{MarvelParameters.credentials}")
      response_body = JSON.parse(response.body)
      if !response_body.nil? && !response_body['data'].nil? && !response_body['data']['results'].nil?
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
  end

  def self.import_characters_events
    Character.all.each do |character|
      response = self.get("/v1/public/characters/#{character.character_id}/events?limit=100&#{MarvelParameters.credentials}")
      response_body = JSON.parse(response.body)
      results = response_body['data']['results']

      results.each do |result|
        event = Event.where(:event_id => result['id']).first
        if event.blank?
          event = Event.new

          thumbnail = result['thumbnail']
          event.thumbnail = thumbnail.blank? ? "" : thumbnail['path']
          event.event_id = result['id']
          event.name = result['title']
          event.description = result['description']

          event.save!
        end

        character.event_characters.create(event: event)
      end
    end
  end

  def self.all_characters
    response = self.get("/v1/public/characters?nameStartsWith=z&orderBy=name&limit=100&offset=0&#{MarvelParameters.credentials}")
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

  def self.write_characters_node
    file = File.new("characters.txt", "w")

    Character.all.each do |character|
      file.puts character.character_id.to_s
      file.puts character.name
    end

    file.close
  end

  def self.write_events
    file = File.new("events.txt", "w")

    Event.all.each do |event|
      file.puts event.event_id.to_s
      file.puts event.name
      file.puts event.characters.count.to_s
      event.characters.all.each do |character|
        file.puts character.character_id.to_s
      end
    end

    file.close
  end

  private

  def self.characters_list
    characters = []

    characters << {:id => 1017100, :name => "A-Bomb (HAS)", :type => "h"}
    characters << {:id => 1009146, :name => "Abomination", :type => "v"}
    characters << {:id => 1009148, :name => "Absorbing Man", :type => "v"}
    characters << {:id => 1010354, :name => "Adam Warlock", :type => "h"}
    characters << {:id => 1009497, :name => "Alexander Pierce", :type => "c"}
    characters << {:id => 1010672, :name => "Amora", :type => "v"}
    characters << {:id => 1009152, :name => "Ancient One", :type => "h"}
    characters << {:id => 1011396, :name => "Angel", :type => "h"}
    characters << {:id => 1010802, :name => "Ant-Man (Eric O'Grady)", :type => "h"}
    characters << {:id => 1010801, :name => "Ant-Man (Scott Lang)", :type => "h"}
    characters << {:id => 1009156, :name => "Apocalypse", :type => "v"}
    characters << {:id => 1010773, :name => "Arachne", :type => "h"}
    characters << {:id => 1010784, :name => "Ares", :type => "v"}
    characters << {:id => 1009740, :name => "Arnim Zola", :type => "v"}
    characters << {:id => 1009164, :name => "Avalanche", :type => "v"}
    characters << {:id => 1011766, :name => "Azazel", :type => "v"}

    characters << {:id => 1009169, :name => "Baron Strucker", :type => "v"}
    characters << {:id => 1009170, :name => "Baron Zemo (Heinrich Zemo)", :type => "v"}
    characters << {:id => 1010906, :name => "Baron Zemo (Helmut Zemo)", :type => "v"}
    characters << {:id => 1009172, :name => "Batroc the Leaper", :type => "v"}
    characters << {:id => 1009175, :name => "Beast", :type => "h"}
    characters << {:id => 1009329, :name => "Ben Grimm", :type => "c"}
    characters << {:id => 1009489, :name => "Ben Parker", :type => "c"}
    characters << {:id => 1009180, :name => "Beta-Ray Bill", :type => "h"}
    characters << {:id => 1009548, :name => "Betty Ross", :type => "c"}
    characters << {:id => 1009182, :name => "Bishop", :type => "h"}
    characters << {:id => 1009184, :name => "Black Bolt", :type => "h"}
    characters << {:id => 1009185, :name => "Black Cat", :type => "a"}
    characters << {:id => 1009187, :name => "Black Panther", :type => "h"}
    characters << {:id => 1009189, :name => "Black Widow", :type => "a"}
    characters << {:id => 1009190, :name => "Blackheart", :type => "v"}
    characters << {:id => 1009191, :name => "Blade", :type => "h"}
    characters << {:id => 1009195, :name => "Blastaar", :type => "v"}
    characters << {:id => 1010830, :name => "Blazing Skull", :type => "h"}
    characters << {:id => 1009199, :name => "Blob", :type => "v"}
    characters << {:id => 1010371, :name => "Boomerang", :type => "v"}
    characters << {:id => 1009167, :name => "Bruce Banner", :type => "c"}
    characters << {:id => 1009211, :name => "Bucky", :type => "h"}
    characters << {:id => 1009212, :name => "Bullseye", :type => "v"}

    characters << {:id => 1009214, :name => "Cable", :type => "h"}
    characters << {:id => 1009220, :name => "Captain America", :type => "h"}
    characters << {:id => 1010338, :name => "Captain Marvel (Carol Danvers)", :type => "h"}
    characters << {:id => 1009224, :name => "Captain Marvel (Mar-Vell)", :type => "h"}
    characters << {:id => 1009225, :name => "Captain Stacy", :type => "c"}
    characters << {:id => 1011027, :name => "Captain Universe", :type => "h"}
    characters << {:id => 1009227, :name => "Carnage", :type => "v"}
    characters << {:id => 1009234, :name => "Chameleon", :type => "v"}
    characters << {:id => 1009733, :name => "Charles Xavier", :type => "h"}
    characters << {:id => 1009241, :name => "Cloak", :type => "h"}
    characters << {:id => 1009243, :name => "Colossus", :type => "h"}
    characters << {:id => 1011362, :name => "Cottonmouth", :type => "v"}
    characters << {:id => 1009252, :name => "Crossbones", :type => "v"}
    characters << {:id => 1009244, :name => "Curt Conners", :type => "c"}
    characters << {:id => 1009257, :name => "Cyclops", :type => "h"}

    characters << {:id => 1010776, :name => "Danny Rand", :type => "h"}
    characters << {:id => 1009262, :name => "Daredevil", :type => "h"}
    characters << {:id => 1009265, :name => "Dark Phoenix", :type => "v"}
    characters << {:id => 1009268, :name => "Deadpool", :type => "a"}
    characters << {:id => 1009269, :name => "Death", :type => "v"}
    characters << {:id => 1010890, :name => "Deathlok", :type => "a"}
    characters << {:id => 1009275, :name => "Doc Samson", :type => "v"}
    characters << {:id => 1009281, :name => "Doctor Doom", :type => "v"}
    characters << {:id => 1009276, :name => "Doctor Octopus", :type => "v"}
    characters << {:id => 1009282, :name => "Doctor Strange", :type => "h"}
    characters << {:id => 1009280, :name => "Dormammu", :type => "v"}
    characters << {:id => 1010677, :name => "Dracula", :type => "v"}
    characters << {:id => 1010735, :name => "Drax", :type => "h"}
    characters << {:id => 1009284, :name => "Dum Dum Dugan", :type => "c"}

    characters << {:id => 1009287, :name => "Electro", :type => "v"}
    characters << {:id => 1009288, :name => "Elektra", :type => "a"}
    characters << {:id => 1009310, :name => "Emma Frost", :type => "v"}
    characters << {:id => 1010671, :name => "Enchantress (Amora)", :type => "v"}

    characters << {:id => 1009297, :name => "Falcon", :type => "h"}
    characters << {:id => 1009335, :name => "Felicia Hardy", :type => "c"}

    characters << {:id => 1009377, :name => "Gabe Jones", :type => "c"}
    characters << {:id => 1009312, :name => "Galactus", :type => "v"}
    characters << {:id => 1009313, :name => "Gambit", :type => "a"}
    characters << {:id => 1010763, :name => "Gamora", :type => "h"}
    characters << {:id => 1010925, :name => "Ghost Rider (Daniel Ketch)", :type => "a"}
    characters << {:id => 1009318, :name => "Ghost Rider (Johnny Blaze)", :type => "a"}
    characters << {:id => 1009320, :name => "Giant Man", :type => "h"}
    characters << {:id => 1009321, :name => "Gladiator (Kallark)", :type => "v"}
    characters << {:id => 1011256, :name => "Gladiator (Melvin Potter)", :type => "v"}
    characters << {:id => 1009645, :name => "Glenn Talbot", :type => "c"}
    characters << {:id => 1011144, :name => "Glorian", :type => "v"}
    characters << {:id => 1014985, :name => "Green Goblin (Barry Norman Osborn)", :type => "v"}
    characters << {:id => 1010928, :name => "Green Goblin (Harry Osborn)", :type => "v"}
    characters << {:id => 1009326, :name => "Gressill", :type => "v"}
    characters << {:id => 1009328, :name => "Grim Reaper", :type => "v"}
    characters << {:id => 1010743, :name => "Groot", :type => "h"}
    characters << {:id => 1009619, :name => "Gwen Stacy", :type => "c"}

    characters << {:id => 1009334, :name => "Hammerhead", :type => "v"}
    characters << {:id => 1009348, :name => "Happy Hogan", :type => "c"}
    characters << {:id => 1009486, :name => "Harry Osborn", :type => "c"}
    characters << {:id => 1009337, :name => "Havok", :type => "h"}
    characters << {:id => 1011490, :name => "Hank Pym", :type => "c"}
    characters << {:id => 1009338, :name => "Hawkeye", :type => "h"}
    characters << {:id => 1009343, :name => "Hercules", :type => "h"}
    characters << {:id => 1010930, :name => "Hobgoblin (Jason Macendale)", :type => "v"}
    characters << {:id => 1009347, :name => "Hobgoblin (Robin Borne)", :type => "v"}
    characters << {:id => 1010931, :name => "Hobgoblin (Roderick Kingsley)", :type => "v"}
    characters << {:id => 1010373, :name => "Howard The Duck", :type => "c"}
    characters << {:id => 1009351, :name => "Hulk", :type => "h"}
    characters << {:id => 1009356, :name => "Human Torch", :type => "h"}

    characters << {:id => 1009362, :name => "Iceman", :type => "h"}
    characters << {:id => 1009366, :name => "Invisible Woman", :type => "h"}
    characters << {:id => 1010888, :name => "Iron Fist (Orson Randall)", :type => "h"}
    characters << {:id => 1009368, :name => "Iron Man", :type => "h"}
    characters << {:id => 1009371, :name => "Iron Monger", :type => "v"}
    characters << {:id => 1009487, :name => "Iron Patriot", :type => "h"}

    characters << {:id => 1009372, :name => "J. Jonah Jameson", :type => "c"}
    characters << {:id => 1010766, :name => "Jack O' Lantern", :type => "v"}
    characters << {:id => 1011288, :name => "Jackal", :type => "v"}
    characters << {:id => 1010329, :name => "Jane Foster", :type => "c"}
    characters << {:id => 1009496, :name => "Jean Grey", :type => "h"}
    characters << {:id => 1009378, :name => "Jessica Jones", :type => "h"}
    characters << {:id => 1009374, :name => "Jigsaw", :type => "v"}
    characters << {:id => 1009196, :name => "Johnny Blaze", :type => "c"}
    characters << {:id => 1009630, :name => "Johnny Storm", :type => "c"}
    characters << {:id => 1009382, :name => "Juggernaut", :type => "v"}
    characters << {:id => 1011310, :name => "Justin Hammer", :type => "v"}

    characters << {:id => 1009384, :name => "Kang", :type => "v"}
    characters << {:id => 1011357, :name => "Karen Page", :type => "c"}
    characters << {:id => 1011289, :name => "Killmonger", :type => "v"}
    characters << {:id => 1009389, :name => "Kingpin", :type => "v"}
    characters << {:id => 1010842, :name => "King Cobra", :type => "v"}
    characters << {:id => 1009390, :name => "Klaw", :type => "v"}
    characters << {:id => 1011147, :name => "Korath", :type => "v"}
    characters << {:id => 1011080, :name => "Korg", :type => "h"}
    characters << {:id => 1011312, :name => "Korvac", :type => "v"}
    characters << {:id => 1009391, :name => "Kraven the Hunter", :type => "v"}

    characters << {:id => 1009398, :name => "Leader", :type => "v"}
    characters << {:id => 1011074, :name => "Lilith", :type => "v"}
    characters << {:id => 1009404, :name => "Lizard", :type => "v"}
    characters << {:id => 1010363, :name => "Logan", :type => "a"}
    characters << {:id => 1009407, :name => "Loki", :type => "v"}
    characters << {:id => 1009215, :name => "Luke Cage", :type => "h"}

    characters << {:id => 1010726, :name => "M.O.D.O.K.", :type => "v"}
    characters << {:id => 1009412, :name => "Madame Hydra", :type => "v"}
    characters << {:id => 1010796, :name => "Madame Web (Julia Carpenter)", :type => "h"}
    characters << {:id => 1009413, :name => "Madrox", :type => "v"}
    characters << {:id => 1011328, :name => "Maestro", :type => "v"}
    characters << {:id => 1009417, :name => "Magneto", :type => "v"}
    characters << {:id => 1009420, :name => "Man-Thing", :type => "v"}
    characters << {:id => 1009421, :name => "Mandarin", :type => "v"}
    characters << {:id => 1011335, :name => "Maria Hill", :type => "c"}
    characters << {:id => 1009708, :name => "Mary Jane Watson", :type => "c"}
    characters << {:id => 1010732, :name => "Master Chief", :type => "h"}
    characters << {:id => 1009463, :name => "Matthew Murdock", :type => "c"}
    characters << {:id => 1009490, :name => "May Parker", :type => "c"}
    characters << {:id => 1009440, :name => "Mephisto", :type => "v"}
    characters << {:id => 1009447, :name => "Mister Sinister", :type => "v"}
    characters << {:id => 1011019, :name => "Molecule Man", :type => "v"}
    characters << {:id => 1009448, :name => "Mojo", :type => "v"}
    characters << {:id => 1009452, :name => "Moon Knight", :type => "a"}
    characters << {:id => 1009454, :name => "Morbius", :type => "v"}
    characters << {:id => 1009459, :name => "Mr. Fantastic", :type => "h"}
    characters << {:id => 1009464, :name => "Mysterio", :type => "v"}
    characters << {:id => 1009465, :name => "Mystique", :type => "v"}

    characters << {:id => 1009466, :name => "Namor", :type => "a"}
    characters << {:id => 1010365, :name => "Nebula", :type => "v"}
    characters << {:id => 1009471, :name => "Nick Fury", :type => "c"}
    characters << {:id => 1009472, :name => "Nightcrawler", :type => "h"}
    characters << {:id => 1009325, :name => "Norman Osborn", :type => "c"}
    characters << {:id => 1010063, :name => "Norrin Radd", :type => "c"}
    characters << {:id => 1009477, :name => "Nova", :type => "h"}

    characters << {:id => 1009620, :name => "Obadiah Stane", :type => "c"}
    characters << {:id => 1009480, :name => "Odin", :type => "h"}
    characters << {:id => 1009482, :name => "Omega Red", :type => "v"}
    characters << {:id => 1009483, :name => "Onslaught", :type => "v"}
    characters << {:id => 1009479, :name => "Otto Octavius", :type => "c"}

    characters << {:id => 1009494, :name => "Pepper Potts", :type => "c"}
    characters << {:id => 1009491, :name => "Peter Parker", :type => "c"}
    characters << {:id => 1010734, :name => "Peter Quill", :type => "c"}
    characters << {:id => 1009504, :name => "Professor X", :type => "h"}
    characters << {:id => 1009505, :name => "Proteus", :type => "v"}
    characters << {:id => 1010865, :name => "Puff Adder", :type => "v"}
    characters << {:id => 1009515, :name => "Punisher", :type => "a"}
    characters << {:id => 1009522, :name => "Pyro", :type => "v"}

    characters << {:id => 1009524, :name => "Quicksilver", :type => "h"}

    characters << {:id => 1009532, :name => "Reaper", :type => "v"}
    characters << {:id => 1011360, :name => "Red Hulk", :type => "a"}
    characters << {:id => 1011436, :name => "Red She-Hulk", :type => "v"}
    characters << {:id => 1009535, :name => "Red Skull", :type => "v"}
    characters << {:id => 1009537, :name => "Rhino", :type => "v"}
    characters << {:id => 1009702, :name => "Rhodey", :type => "c"}
    characters << {:id => 1010744, :name => "Rocket Raccoon", :type => "h"}
    characters << {:id => 1009546, :name => "Rogue", :type => "h"}
    characters << {:id => 1010344, :name => "Ronan", :type => "v"}
    characters << {:id => 1009551, :name => "Russian", :type => "v"}

    characters << {:id => 1009554, :name => "Sabretooth", :type => "v"}
    characters << {:id => 1009558, :name => "Sandman", :type => "v"}
    characters << {:id => 1009561, :name => "Sauron", :type => "v"}
    characters << {:id => 1009562, :name => "Scarlet Witch", :type => "h"}
    characters << {:id => 1009568, :name => "Selene", :type => "v"}
    characters << {:id => 1009570, :name => "Sentinel", :type => "v"}
    characters << {:id => 1009574, :name => "Shadowcat", :type => "h"}
    characters << {:id => 1009228, :name => "Sharon Carter", :type => "c"}
    characters << {:id => 1009583, :name => "She-Hulk (Jennifer Walters)", :type => "h"}
    characters << {:id => 1011392, :name => "She-Hulk (Lyra)", :type => "h"}
    characters << {:id => 1009585, :name => "Shocker (Herman Schultz)", :type => "v"}
    characters << {:id => 1009588, :name => "Sif", :type => "h"}
    characters << {:id => 1009591, :name => "Silver Samurai", :type => "v"}
    characters << {:id => 1009592, :name => "Silver Surfer", :type => "h"}
    characters << {:id => 1011223, :name => "Skaar", :type => "a"}
    characters << {:id => 1009610, :name => "Spider-Man", :type => "h"}
    characters << {:id => 1010733, :name => "Star-Lord (Peter Quill)", :type => "h"}
    characters << {:id => 1010326, :name => "Steve Rogers", :type => "c"}
    characters << {:id => 1009629, :name => "Storm", :type => "h"}

    characters << {:id => 1009644, :name => "T'Challa", :type => "c"}
    characters << {:id => 1009648, :name => "Taskmaster", :type => "v"}
    characters << {:id => 1009651, :name => "Terrax", :type => "v"}
    characters << {:id => 1011003, :name => "Thaddeus Ross", :type => "c"}
    characters << {:id => 1009652, :name => "Thanos", :type => "v"}
    characters << {:id => 1010728, :name => "The Executioner", :type => "v"}
    characters << {:id => 1009656, :name => "The Phantom", :type => "h"}
    characters << {:id => 1009662, :name => "Thing", :type => "h"}
    characters << {:id => 1009664, :name => "Thor", :type => "h"}
    characters << {:id => 1010885, :name => "Thunderball", :type => "v"}
    characters << {:id => 1014812, :name => "Thunderbolt Ross", :type => "c"}
    characters << {:id => 1009624, :name => "Tony Stark", :type => "c"}

    characters << {:id => 1009683, :name => "Uatu The Watcher", :type => "h"}
    characters << {:id => 1010358, :name => "Ulik", :type => "v"}
    characters << {:id => 1009685, :name => "Ultron", :type => "v"}

    characters << {:id => 1009663, :name => "Venom (Flash Thompson)", :type => "h"}
    characters << {:id => 1010788, :name => "Venom (Mac Gargan)", :type => "v"}
    characters << {:id => 1010324, :name => "Victor Von Doom", :type => "c"}
    characters << {:id => 1009696, :name => "Viper", :type => "v"}
    characters << {:id => 1009697, :name => "Vision", :type => "h"}
    characters << {:id => 1009699, :name => "Vulture (Adrian Toomes)", :type => "v"}
    characters << {:id => 1010990, :name => "Vulture (Blackie Drago)", :type => "v"}

    characters << {:id => 1010991, :name => "War Machine (Parnell Jacobs)", :type => "h"}
    characters << {:id => 1009707, :name => "Wasp", :type => "h"}
    characters << {:id => 1009711, :name => "Whiplash (Mark Scarlotti)", :type => "v"}
    characters << {:id => 1010740, :name => "Winter Soldier", :type => "a"}
    characters << {:id => 1010853, :name => "White Tiger (Angela Del Toro)", :type => "v"}
    characters << {:id => 1009718, :name => "Wolverine", :type => "a"}
    characters << {:id => 1010737, :name => "Wraith", :type => "v"}
    characters << {:id => 1010884, :name => "Wrecker", :type => "v"}

    characters << {:id => 1010780, :name => "Zemo", :type => "v"}
    characters << {:id => 1009742, :name => "Zzzax", :type => "v"}

    characters
  end
end
