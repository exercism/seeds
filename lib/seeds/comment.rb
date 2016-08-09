class Comment
  def self.on(submission, user_id, at)
    attributes = {
      user_id: user_id,
      submission_id: submission.id,
      body: 'A COMMENT',
      created_at: at,
      updated_at: at,
    }
    TARGET[:comments].insert(attributes)

    sql = <<-SQL
    SELECT commented_at FROM
    (
      SELECT MIN(c.created_at) AS commented_at
      FROM comments c
      INNER JOIN submissions s
      ON c.submission_id=s.id
      WHERE c.user_id != s.user_id
      AND c.user_id=#{user_id}
      GROUP BY s.user_id
    ) t
    ORDER BY commented_at ASC
    LIMIT 1 OFFSET 2
    SQL
    result = TARGET[sql].to_a.first
    return if result.nil?

    at = result[:commented_at]
    TARGET[:users].where(id: user_id).update(onboarded_at: at)
  end
end
