require 'time'

module Chronology
  def self.random(length, earliest)
    length.times.map { Time.at(rand(earliest.to_i..Time.now.to_i)) }.sort
  end
end
