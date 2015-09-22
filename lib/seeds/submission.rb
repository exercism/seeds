class Submission < OpenStruct
  def self.create(attributes, exercise, at)
    [:id, :is_liked, :done_at].each {|key|
      attributes.delete(key)
    }
    attributes.update(
      nit_count: 0,
      key: Key.submission,
      user_id: exercise.user_id,
      user_exercise_id: exercise.id,
      created_at: at,
      updated_at: at,
    )
    id = TARGET[:submissions].insert(attributes)
    attributes[:id] = id
    LifecycleEvent.track('submitted', exercise.user_id, at)
    ACL.authorize(exercise.user_id, exercise.language, exercise.slug, at)
    new attributes
  end

  def archive!
    TARGET[:user_exercises].where(id: user_exercise_id).update(:archived => true)
    LifecycleEvent.track('completed', user_id, Timestamp.sometime_after(created_at))
  end
end
