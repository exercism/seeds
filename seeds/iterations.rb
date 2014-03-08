class Iterations
  def self.create(n, username, language=nil)
    user = User.find(username)
    n.times do
      Iterations.new(user, *Exercise.random(language)).save
    end
  end

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
    @timestamps ||= Sequence.random(submissions.length+1, user.created_at)
  end

  def save
    return if exists?

    ex = Exercise.create(user, timestamps, exercise)
    HibernationAlert.for(user, ex) if ex.hibernating?

    submissions.zip(timestamps).each do |submission, timestamp|
      Submission.new(ex, timestamp, submission).save
    end
  end
end
