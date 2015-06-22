class LifecycleEvent
  def self.track(key, id, at)
    if TARGET[:lifecycle_events].where(user_id: id, key: key).count > 0
      return
    end
    if at.nil?
      raise "timestamp should never be null"
    end

    TARGET[:lifecycle_events].insert(
      user_id: id,
      key: key,
      happened_at: at,
      created_at: at,
      updated_at: at
    )
  end
end
