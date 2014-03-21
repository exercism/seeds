class Comment
  def self.on(submission)
    nitpickers = PeerGroup.new(submission).nitpickers.sample(count)
    timestamps = Chronology.random(nitpickers.size, submission.created_at)
    nitpickers.zip(timestamps).each { |nitpicker, at|
      data = {
        user_id: nitpicker,
        submission_id: submission.id,
        body: 'NO COMMENT',
        created_at: at,
        updated_at: at,
      }
      TARGET[:comments].insert(data)
    }
    TARGET[:submissions].where(:id => submission.id).update(:nit_count => nitpickers.count)
  end

  def self.count
    case rand(10)
    when 0..1
      0
    when 2..6
      rand(1..5)
    when 7..8
      rand(5..10)
    when 9
      rand(10..20)
    end
  end
end
