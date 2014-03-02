class Exercise
  def self.random(db, language=nil)
    query = db[:user_exercises]
    query = query.where(language: language) if language
    exercise = query.limit(1, rand(query.count)).first
    submissions = db[:submissions].where(user_exercise_id: exercise[:id]).all
    [exercise, submissions]
  end

  attr_reader :user, :timestamps, :attributes, :id
  def initialize(user, timestamps, attributes)
    @user = user
    @timestamps = timestamps
    @attributes = attributes
  end

  def save_to(db)
    attributes.delete(:id)
    attributes.update(overrides)
    @id = db[:user_exercises].insert(attributes)
    self
  end

  def done?
    attributes[:state] == 'done'
  end

  def created_at
    timestamps.first
  end

  def updated_at
    done? ? timestamps.last : timestamps.first
  end

  def completed_at
    timestamps.last if done?
  end

  def overrides
    {
      user_id: user.id,
      key: Key.exercise,
      created_at: created_at,
      completed_at: completed_at,
      updated_at: updated_at
    }
  end
end
