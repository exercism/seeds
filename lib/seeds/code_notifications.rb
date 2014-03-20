class CodeNotifications
  DAYS = 60*60*24

  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def process
    nitpickers.select { |_| notify? }.each do |nitpicker|
      TARGET[:notifications].insert(attributes.merge(user_id: nitpicker))
    end
  end

  def nitpickers
    (participants | managers).map(&ids) - [user_id]
  end

  def ids
    Proc.new {|row| row[:user_id]}
  end

  def participants
    criteria = {
      language: submission.language, slug: submission.slug, is_nitpicker: true
    }
    TARGET[:user_exercises].where(criteria).where("completed_at < '#{at}'").select(:user_id).all
  end

  def managers
    TARGET[:team_managers].select(:team_managers__user_id).join(:team_memberships, :team_id => :team_id, :user_id => user_id).all
  end

  # Always notify if the submission is recent.
  # If it's aging, notify about 60% of the time.
  # If it's old, notify about 20% of the time.
  def notify?
    recent? || (aging? && rand(5) < 3) || rand(5) == 0
  end

  def attributes
    {
      "item_id" => submission.exercise_id,
      "regarding" => "code",
      "read" => read?,
      "count" => 1,
      "created_at" => at,
      "updated_at" => at,
      "item_type" => "UserExercise",
      "creator_id" => user_id
    }
  end

  def read?
    recent? && rand(5) < 3
  end

  def recent?
    at > (Time.now - 2*DAYS)
  end

  def aging?
    !recent? && (at > (Time.now - 7*DAYS))
  end

  def at
    submission.created_at
  end

  def user_id
    submission.user_id
  end
end
