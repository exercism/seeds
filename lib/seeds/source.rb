class Source
  def self.random_exercise
    exercises.limit(1, offset).first
  end

  def self.submissions_in(exercise)
    SOURCE[:submissions].where(user_exercise_id: exercise[:id]).all
  end

  def self.exercises
    SOURCE[:user_exercises]
  end

  def self.offset
    rand(exercises.count)
  end
end
