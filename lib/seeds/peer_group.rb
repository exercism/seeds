class PeerGroup
  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def nitpickers
    (participants | managers).map(&ids) - [user_id]
  end

  private

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

  def user_id
    submission.user_id
  end

  def at
    submission.created_at
  end
end
