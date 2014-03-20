class Avatar
  URLS = File.read('./fixtures/faces.dat').split("\n")

  def self.random
    URLS.sample
  end
end
