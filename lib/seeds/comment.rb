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

    if submission.user_id != user_id
      LifecycleEvent.track('received_feedback', submission.user_id, at)
      LifecycleEvent.track('commented', user_id, at)
    end
  end
end
