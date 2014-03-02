module Key
  def self.generate
    key = ''
    3.times { key << ('a'..'z').to_a.sample }
    key << rand(100..999).to_s
  end
end
