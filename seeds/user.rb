module User
  def self.create(db, username, attributes={})
    attributes = default(username, Timestamp.random).merge(attributes)
    db[:users].insert(attributes)
  end

  def self.default(username, at)
    {
      username: username,
      key: Key.generate,
      github_id: GitHub.id,
      created_at: at,
      updated_at: at
    }
  end
end
