require 'delegate'

class Notification < SimpleDelegator
  def self.process(submission)
    note = Notification::Code.new(submission)
    nitpickers = PeerGroup.new(submission).nitpickers.select { |_| note.notify? }
    nitpickers.each do |nitpicker|
      TARGET[:notifications].insert(note.attributes.merge(user_id: nitpicker))
    end
  end

  class Code < SimpleDelegator
    DAYS = 60*60*24

    # Always notify if the submission is recent.
    # If it's aging, notify about 60% of the time.
    # If it's old, notify about 20% of the time.
    def notify?
      recent? || (aging? && rand(5) < 3) || rand(5) == 0
    end

    def attributes
      {
        "item_id" => id,
        "regarding" => "code",
        "read" => read?,
        "count" => 1,
        "created_at" => created_at,
        "updated_at" => created_at,
        "item_type" => "Submission",
        "creator_id" => user_id
      }
    end

    def read?
      recent? && rand(5) < 3
    end

    def recent?
      created_at > (Time.now - 2*DAYS)
    end

    def aging?
      !recent? && (created_at > (Time.now - 7*DAYS))
    end
  end
end
