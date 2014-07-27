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
      state: default_state(attributes[:state]),
    )
    id = TARGET[:submissions].insert(attributes)
    attributes[:id] = id
    LifecycleEvent.track('submitted', exercise.user_id, at)
    new attributes
  end

  def self.default_state(state)
    return state if state == 'superseded'

    'pending'
  end

  def pending?
    state == 'pending'
  end

  def done!
    at = Timestamp.sometime_after(created_at)
    TARGET[:submissions].where(:id => id).update(:done_at => at, :state => 'done')
    TARGET[:user_exercises].where(id: user_exercise_id).update(
      :is_nitpicker => true,
      :state => 'done',
      :completed_at => at
    )
    LifecycleEvent.track('completed', user_id, at)
  end
end
