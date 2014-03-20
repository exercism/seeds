class Sequence
  def self.create(n, username, language=nil)
    user = User.find(username)
    n.times do
      Sequence.new(user, *Exercise.random(language)).save
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
    @timestamps ||= Chronology.random(submissions.length+1, user.created_at)
  end

  def save
    return if exists?

    ex = Exercise.create(user, timestamps, exercise)
    HibernationAlert.for(user, ex) if ex.hibernating?

    submissions.zip(timestamps).each do |submission, timestamp|
      attributes = {
        user_exercise_id: ex.id,
        user_id: ex.user_id,
        created_at: timestamp,
        updated_at: timestamp
      }
      Submission.create(submission.update(attributes))
    end
  end
end
