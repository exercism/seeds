class Submission < OpenStruct

  def self.create(attributes)
    attributes.delete(:id)
    TARGET[:submissions].insert(new(attributes).to_h)
  end

  def to_h
    super.to_h.update(overrides)
  end

  def overrides
    {
      key: Key.submission,
      is_liked: false,
      nit_count: 0,
      done_at: nil
    }
  end
end
