module Some
  def self.times
    count.times
  end

  def self.count
    case rand(10)
    when 0..1
      1
    when 2..7
      rand(2..7)
    else
      rand(7..50)
    end
  end
end
