class Submission
  attr_reader :exercise, :at, :attributes, :id

  def initialize(exercise, at, attributes)
    @exercise = exercise
    @at = at
    @attributes = attributes
  end

  def save_to(db)
    attributes.delete(:id)
    attributes.update(overrides)
    @id = db[:submissions].insert(attributes)
    self
  end

  def overrides
    {
      is_liked: nil, nit_count: 0, done_at: nil,
      user_exercise_id: exercise.id, user_id: exercise.user.id,
      created_at: at, updated_at: at,
      key: Key.submission
    }
  end
end
