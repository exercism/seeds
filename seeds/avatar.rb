class Avatar
  URLS = File.read('./seeds/faces.dat').split("\n")

  def self.random
    URLS.sample
  end
end
