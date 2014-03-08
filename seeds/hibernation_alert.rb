class HibernationAlert

  def self.for(user, exercise)
    TARGET[:alerts].insert(new(user, exercise).to_h)
  end

  attr_reader :user, :exercise
  def initialize(user, exercise)
    @user = user
    @exercise = exercise
    @at = at
  end

  def to_h
    {
      "user_id" => user.id,
      "text" => text,
      "url" => url,
      "link_text"=>"View submission.",
      "read" => false,
      "created_at" => at,
      "updated_at" => at
    }
  end

  private

  def at
    exercise.updated_at
  end

  def url
    "/#{user.username}/#{exercise.key}"
  end

  def text
    "Your exercise #{exercise.slug} in #{exercise.language} has gone into hibernation."
  end
end
