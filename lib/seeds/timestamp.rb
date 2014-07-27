module Timestamp
  def self.random
    Time.now - rand(60*60*24*30*9)
  end

  def self.soon_after(timestamp)
    timestamp + rand(120..600)
  end

  def self.sometime_after(timestamp)
    at = timestamp + rand(600..1_000_000)
    [Time.now, at].min
  end
end
