class Link < ApplicationRecord
  has_many :uses, class_name: 'LinkUse'
  before_validation :assign_slug, on: :create

  validates :url, presence: true
  validates :slug, presence: true, uniqueness: true

  SLUG_CHARS = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a - %w[l I 1 O 0]
  SLUG_LENGTH = 8

  def self.language_filter
    @_language_filter ||= LanguageFilter::Filter.new
  end

  def to_param
    slug
  end

  def to_hash(url_context)
    {
      id: id,
      slug: slug,
      description: description,
      url: url,
      shortened_url: shortened_url(url_context),
      uses_count: uses_count,
      first_used_at: first_used_at,
      last_used_at: last_used_at,
      '$ref': url_context.link_path(self),
      uses: uses.map(&:to_hash),
    }
  end

  def shortened_url(url_context)
    url_context.shortened_link_url(slug)
  end

  private

  def generate_slug
    Array.new(SLUG_LENGTH) { SLUG_CHARS.sample }.join
  end

  def assign_slug
    return if slug.present?

    loop do
      self.slug = generate_slug
      break unless self.class.language_filter.match?(slug) || self.class.exists?(slug: slug)
    end
  end
end
