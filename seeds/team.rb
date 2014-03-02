class Team
  attr_reader :name, :at, :id, :db
  def initialize(name, db)
    @name = name
    @db = db
    @at = Timestamp.random
  end

  def attributes
    {created_at: at, updated_at: at, slug: name, name: name}
  end

  def save
    @id = db[:teams].insert(attributes)
    self
  end

  def managed_by(user)
    db[:team_managers].insert(user_id: user.id, team_id: id)
  end

  def add(user)
    at = Sequence.random(1, at).first
    db[:team_memberships].insert(user_id: user.id, team_id: id, confirmed: true, created_at: at, updated_at: at)
  end

  def invite(user)
    at = Sequence.random(1, at).first
    db[:team_memberships].insert(user_id: user.id, team_id: id, confirmed: false, created_at: at, updated_at: at)
  end
end
