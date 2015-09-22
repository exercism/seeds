module ACL
  def self.authorize(user_id, language, slug, at)
    attributes = {
      user_id: user_id,
      language: language,
      slug: slug,
      created_at: at,
      updated_at: at,
    }
    TARGET[:acls].insert(attributes)
  rescue Sequel::UniqueConstraintViolation
    # that's fine
  end
end
