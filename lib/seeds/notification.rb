class Notification
  def self.process(submission)
    code = Code.new(submission)
    nitpickers = PeerGroup.new(submission).nitpickers.select { |_| code.notify? }
    nitpickers.each do |nitpicker|
      TARGET[:notifications].insert(code.attributes.merge(user_id: nitpicker))
    end
  end
end
