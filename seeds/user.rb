class User
  attr_reader :at, :username, :attributes, :id

  def initialize(username, attributes={})
    @at = Timestamp.random
    @username = username
    @attributes = default_attributes.update(attributes)
  end

  def save_to(db)
    @id = db[:users].insert(attributes)
    self
  end

  private

  def default_attributes
    {
      username: username,
      key: Key.user,
      github_id: GitHub.id,
      created_at: at,
      updated_at: at
    }
  end
end
