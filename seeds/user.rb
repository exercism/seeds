class User < OpenStruct
  def self.create(username, attributes={})
    user = new({username: username}.merge(attributes))
    id = TARGET[:users].insert(user.to_h)
    user.id = id
    user
  end

  def initialize(attributes)
    super(default_attributes.update(attributes))
  end

  def submit(n, source_db, destination_db, language=nil)
    n.times do
      Iterations.new(self, *Exercise.random(source_db, language)).save_to(destination_db)
    end
  end

  private

  def at
    @at ||= Timestamp.random
  end

  def default_attributes
    {
      key: Key.user,
      github_id: GitHub.id,
      created_at: at,
      updated_at: at,
      mastery: [].to_yaml
    }
  end
end
