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

  def exists?
    TARGET[:user_exercises].where(to_h).count > 0
  end

  def timestamps
    @timestamps ||= Sequence.random(submissions.length+1, user.at)
  end

  def save
    return if exists?

    ex = Exercise.new(user, timestamps, exercise).save

    submissions.zip(timestamps).each do |submission, timestamp|
      Submission.new(ex, timestamp, submission).save
    end
  end
end
