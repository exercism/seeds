require 'digest/sha1'

module Key
  def self.user
    key = ''
    3.times { key << ('a'..'z').to_a.sample }
    key << rand(100..999).to_s
  end

  def self.submission
    Digest::SHA1.hexdigest("We all know interspecies romance is weird. #{rand(10**10)}")[0..23]
  end

  def self.exercise
    Digest::SHA1.hexdigest("Time is an illusion. Lunchtime doubly so. #{rand(10**10)}")[0..23]
  end
end
