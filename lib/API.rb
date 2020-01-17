class API
  BASE_URL = "http://api.tvmaze.com/"

  def initialize
  end

  def self.results(extended_url)
    response = RestClient.get(BASE_URL + extended_url)
    return JSON.parse(response.body)
  end

  def self.fetch_show(keyword="west wing")
    shows = results("search/shows?q="+keyword)
    results=[]
    shows.each do |score_show|
      #ap score_show
      show = score_show["show"]
      if show["language"]=="English"
        results << Show.create(show)
      end #binding.pry
    end
    results
  end

=begin
cast is an array of hash
[ {"person"=>v:person_hash, "character"=>v:character_hash} ]
=end
  def self.fetch_cast_for_show(show_id="523")
    # http://api.tvmaze.com/shows/1/cast
    cast = results("shows/"+show_id.to_s+"/cast")
    cast_of_characters=[]
    #ap cast
    cast.each do |actor_character|
      actor = actor_character["person"]
      a= Actor.create(actor)
      #ap a
      character = actor_character["character"]
      c = Character.create(character)
      #ap c
      # add the relationship between actor and character
      a.add_role(c)
      c.add_actor(a)
      cast_of_characters<<c
        #binding.pry
    end
    cast_of_characters
  end


end


#API.fetch_shows
#API.fetch_cast
