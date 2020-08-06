class LinkUse < ApplicationRecord
  belongs_to :link, inverse_of: :uses, counter_cache: :uses_count

  def ip_address=(ip)
    self.identity = Digest::MD5.hexdigest(Rails.application.secrets.secret_key_base + ip)
  end

  def to_hash
    {
      id: id,
      link_id: link_id,
      created_at: created_at,
      identity: identity,
      user_agent: user_agent,
    }
  end
end
