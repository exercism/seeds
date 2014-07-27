class LifecycleEvent
  def self.track(key, id, at)
    if TARGET[:lifecycle_events].where(user_id: id, key: key).count > 0
      return
    end

    TARGET[:lifecycle_events].insert(user_id: id, key: key, happened_at: at)
  end
end
