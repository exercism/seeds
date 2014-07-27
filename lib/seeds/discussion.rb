class Discussion
  def self.about(submission, nitpickers)
    # allow duplicates
    usernames = (nitpickers + nitpickers + nitpickers).sample(count)
    user_ids = usernames.map {|username| User.find(username)}.map(&:id)
    timestamps = Chronology.random(user_ids.size, submission.created_at)
    user_ids.zip(timestamps).each { |user_id, at|
      Comment.on(submission, user_id, at)
    }
  end

  def self.count
    case rand(10)
    when 0..2
      0
    when 3..6
      rand(1..5)
    when 7..8
      rand(5..10)
    when 9
      rand(10..20)
    end
  end
end
