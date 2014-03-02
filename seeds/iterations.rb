class Iterations
  attr_reader :user, :exercise, :submissions

  def initialize(user, exercise, submissions)
    @user = user
    @exercise = exercise
    @submissions = submissions
  end

  def to_h
    {language: exercise[:language], slug: exercise[:slug], user_id: user.id}
  end

  def already_in?(db)
    db[:user_exercises].where(to_h).count > 0
  end

  def timestamps
    @timestamps ||= Sequence.random(submissions.length+1, user.at)
  end

  def save_to(db)
    return if already_in?(db)

    ex = Exercise.new(user, timestamps, exercise).save_to(db)

    submissions.zip(timestamps).each do |submission, timestamp|
      Submission.new(ex, timestamp, submission).save_to(db)
    end
  end
end
