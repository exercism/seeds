class Avatar
  URLS = File.read('./lib/seeds/faces.dat').split("\n")

  def self.random
    URLS.sample
  end
end
