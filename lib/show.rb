class Show
  attr_accessor :id, :url, :name, :language, :summary, :api_url, :genres,
                :network, :premiered, :status, :schedule, :cast
  # :cast is an array of Character objects
  @@all=[]
  def initialize(attributes)
    attributes.each do |k,v|
      self.send("#{k}=",v) if self.respond_to?("#{k}=")
    end
    @api_url=attributes["_links"]["self"]["href"]
  end

  def self.create(attributes)
    show = Show.new(attributes)
    show.save
    show
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end

  def cast
    if @cast.nil?
      populate_cast_of_characters
    end
    @cast
  end

  def populate_cast_of_characters
    @cast= API.fetch_cast_for_show(self.id)
  end


end


=begin
<Show:0x00007fffcd9d3918
@api_url="http://api.tvmaze.com/shows/523",
    @genres=["Drama"],
    @id=523,
    @language="English",
    @name="The West Wing",
    @network={"id"=>1, "name"=>"NBC", "country"=>{"name"=>"United States", "code"=>"US", "timezone"=>"America/New_York"}},
    @premiered="1999-09-22",
    @schedule={"time"=>"20:00", "days"=>["Sunday"]},
    @status="Ended",
    @summary=
        "<p>The entire White House staff bristles with activity when it's learned that the President injured himself during a bicycle accid
ent, and his absence becomes a factor as chief of staff Leo McGarry must juggle a host of impending crises, including a mass boatlift
 of Cuban refugees approaching the Florida coast and the reaction of conservative Christians to a controversial televised comment by
deputy chief of staff Josh Lyman.</p>",
    @url="http://www.tvmaze.com/shows/523/the-west-wing">

        {"id"=>523,
         "url"=>"http://www.tvmaze.com/shows/523/the-west-wing",
         "name"=>"The West Wing",
         "type"=>"Scripted",
         "language"=>"English",
         "genres"=>["Drama"],
         "status"=>"Ended",
         "runtime"=>60,
         "premiered"=>"1999-09-22",
         "officialSite"=>nil,
         "schedule"=>{"time"=>"20:00", "days"=>["Sunday"]},
         "rating"=>{"average"=>9.1},
         "weight"=>85,
         "network"=>{"id"=>1, "name"=>"NBC", "country"=>{"name"=>"United States", "code"=>"US", "timezone"=>"America/New_York"}},
         "webChannel"=>nil,
         "externals"=>{"tvrage"=>6289, "thetvdb"=>72521, "imdb"=>"tt0200276"},
         "image"=>
             {"medium"=>"http://static.tvmaze.com/uploads/images/medium_portrait/4/11284.jpg",
              "original"=>"http://static.tvmaze.com/uploads/images/original_untouched/4/11284.jpg"},
         "summary"=>
             "<p>The entire White House staff bristles with activity when it's learned that the President injured himself during a bicycle accid
ent, and his absence becomes a factor as chief of staff Leo McGarry must juggle a host of impending crises, including a mass boatlift
 of Cuban refugees approaching the Florida coast and the reaction of conservative Christians to a controversial televised comment by
deputy chief of staff Josh Lyman.</p>",
         "updated"=>1573660692,
         "_links"=>
             {"self"=>{"href"=>"http://api.tvmaze.com/shows/523"}, "previousepisode"=>{"href"=>"http://api.tvmaze.com/episodes/47435"}}}

=end
