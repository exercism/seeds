class Comment
  def self.in(language)
    %x{./bin/markov g -f fixtures/markov/#{language}.json}
  end
end
