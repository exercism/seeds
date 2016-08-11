require 'sequel/extensions/pg_array'

class Team
  attr_reader :name, :public, :tags, :at, :id
  def initialize(name, public = true)
    @name = name
    @public = public
    @tags = []
    @at = Timestamp.random
  end

  def attributes
    {created_at: at, updated_at: at, slug: name, name: name, public: public, tags: tags}
  end

  def set_tags(*tags)
    @tags = Sequel.pg_array(TARGET[:tags].where(name: tags).map(:id))
    self
  end

  def save
    @id = TARGET[:teams].insert(attributes)
    self
  end

  def managed_by(*usernames)
    usernames.each do |username|
      user = User.find(username)
      TARGET[:team_managers].insert(user_id: user.id, team_id: id)
    end
  end

  def add(*usernames)
    usernames.each do |username|
      user = User.find(username)
      at = Chronology.random(1, at).first
      TARGET[:team_memberships].insert(user_id: user.id, team_id: id, confirmed: true, created_at: at, updated_at: at)
    end
  end

  def invite(*usernames)
    usernames.each do |username|
      user = User.find(username)
      at = Chronology.random(1, at).first
      TARGET[:team_memberships].insert(user_id: user.id, team_id: id, confirmed: false, created_at: at, updated_at: at)
    end
  end
end
