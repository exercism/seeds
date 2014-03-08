class Exercise < OpenStruct
  def self.random(language=nil)
    query = SOURCE[:user_exercises]
    query = query.where(language: language) if language
    exercise = query.limit(1, rand(query.count)).first
    submissions = SOURCE[:submissions].where(user_exercise_id: exercise[:id]).all
    [exercise, submissions]
  end

  def self.create(user, timestamps, attributes)
    exercise = new(attributes.update(user: user, timestamps: timestamps))
    id = TARGET[:user_exercises].insert(exercise.to_h)
    exercise.id = id
    exercise
  end

  def to_h
    {
      user_id: user.id,
      language: language,
      slug: slug,
      iteration_count: iteration_count,
      state: state,
      key: Key.exercise,
      is_nitpicker: is_nitpicker,
      created_at: created_at,
      updated_at: updated_at,
      completed_at: completed_at
    }
  end

  def hibernating?
    state == 'hibernating'
  end

  def done?
    state == 'done'
  end

  def created_at
    timestamps.first
  end

  def updated_at
    done? || hibernating? ? timestamps.last : timestamps.first
  end

  def completed_at
    timestamps.last if done?
  end
end
