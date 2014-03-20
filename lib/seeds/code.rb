require 'delegate'

class Code < SimpleDelegator
  DAYS = 60*60*24

  # Always notify if the submission is recent.
  # If it's aging, notify about 60% of the time.
  # If it's old, notify about 20% of the time.
  def notify?
    recent? || (aging? && rand(5) < 3) || rand(5) == 0
  end

  def attributes
    {
      "item_id" => user_exercise_id,
      "regarding" => "code",
      "read" => read?,
      "count" => 1,
      "created_at" => created_at,
      "updated_at" => created_at,
      "item_type" => "UserExercise",
      "creator_id" => user_id
    }
  end

  def read?
    recent? && rand(5) < 3
  end

  def recent?
    created_at > (Time.now - 2*DAYS)
  end

  def aging?
    !recent? && (created_at > (Time.now - 7*DAYS))
  end
end

