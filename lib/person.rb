
class Person
  attr_accessor :name, :id, :birthday, :gender
  @@all=[]

  def initialize(attributes)
    attributes.each do |k,v|
      self.send("#{k}=",v) if self.respond_to?("#{k}=")
    end
  end

  def self.create(attributes)
    p = Person.new(attributes)
    p.save
    p
  end

  def save
    @@all<<self
  end

  def self.all
    @@all
  end
end
