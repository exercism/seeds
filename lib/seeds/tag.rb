class Tag
  attr_reader :name, :at, :id
  def initialize(name)
    @name = name
    @at = Timestamp.random
  end

  def attributes
    {created_at: at, updated_at: at, name: name}
  end

  def save
    @id = TARGET[:tags].insert(attributes)
    self
  end
end
