class Exercise < OpenStruct
  def self.exists?(attributes, user)
    values = {
      user_id: user.id,
      language: attributes[:language],
      slug: attributes[:slug]
    }
    TARGET[:user_exercises].where(values).count > 0
  end

  def self.create(attributes, user, at, active_at)
    [:id].each {|key|
      attributes.delete(key)
    }
    attributes.update(
      user_id: user.id,
      key: Key.exercise,
      last_iteration_at: active_at,
      last_activity_at: active_at,
      created_at: at,
      updated_at: at,
    )
    id = TARGET[:user_exercises].insert(attributes)
    attributes[:id] = id
    new attributes
  end
end
