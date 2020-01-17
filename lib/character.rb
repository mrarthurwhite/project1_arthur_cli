
class Character < Person
  attr_accessor :character_summary , :actors

  def initialize(attributes)
    super(attributes)
    attributes.each do |k,v|
      self.send("#{k}=",v) if self.respond_to?("#{k}=")
    end
    @actors=[]
  end

  def self.create(attributes)
    c = Character.new(attributes)
    c.save
    c
  end

  def add_actor(actor)
    @actors<< actor unless @actors.include?(actor)
  end


end



=begin
=> {"id"=>85529,
    "url"=>"http://www.tvmaze.com/characters/85529/the-west-wing-josh-lyman",
    "name"=>"Josh Lyman",
    "image"=>
        {"medium"=>"http://static.tvmaze.com/uploads/images/medium_portrait/4/11287.jpg",
         "original"=>"http://static.tvmaze.com/uploads/images/original_untouched/4/11287.jpg"},
    "_links"=>{"self"=>{"href"=>"http://api.tvmaze.com/characters/85529"}}}
=end
