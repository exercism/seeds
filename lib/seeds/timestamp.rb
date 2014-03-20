module Timestamp
  def self.random
    Time.now - rand(60*60*24*30*9)
  end
end
