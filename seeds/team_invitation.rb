class TeamInvitation

  def self.for(user, team)
    TARGET[:alerts].insert(new(user, team).to_h)
  end

  attr_reader :user, :team
  def initialize(user, team)
    @user = user
    @team = team
  end

  def to_h
    {
      "user_id" => user.id,
      "text" => text,
      "url" => "/account",
      "link_text" => "on your account page.",
      "read" => false,
      "created_at" => at,
      "updated_at" => at
    }
  end

  private

  def text
    "#{user.username} would like you to join the team #{team.name}. You can accept the invitation"
  end

  def at
    @at ||= Sequence.random(1, team.at).first
  end
end
