
class Actor < Person
  attr_accessor  :roles, :country

  def initialize(attributes)
    super(attributes)
    attributes.each do |k,v|
      self.send("#{k}=",v) if self.respond_to?("#{k}=")
    end
    @roles=[]
  end

  def self.create(attributes)
    a = Actor.new(attributes)
    a.save
    a
  end

  def add_role(character)
    @roles<< character unless @roles.include?(character)
  end
end



=begin
=> {"id"=>25249,
    "url"=>"http://www.tvmaze.com/people/25249/bradley-whitford",
    "name"=>"Bradley Whitford",
    "country"=>{"name"=>"United States", "code"=>"US", "timezone"=>"America/New_York"},
    "birthday"=>"1959-10-10",
    "deathday"=>nil,
    "gender"=>"Male",
    "image"=>
        {"medium"=>"http://static.tvmaze.com/uploads/images/medium_portrait/183/459454.jpg",
         "original"=>"http://static.tvmaze.com/uploads/images/original_untouched/183/459454.jpg"},
    "_links"=>{"self"=>{"href"=>"http://api.tvmaze.com/people/25249"}}}
=end
