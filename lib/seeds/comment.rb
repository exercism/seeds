class Comment
  def self.in(language)
    %x{./bin/markov g -f markov/#{language}.json}
  end
end
