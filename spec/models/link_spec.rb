require "rails_helper"

RSpec.describe Link, type: :model do
  describe '#slug' do
    it 'avoids problematic words' do
      link = Link.new(url: 'https://example.com')

      calls = 0
      allow(link).to receive(:generate_slug) do
        calls += 1
        if calls < 5
          'ushit'
        else
          'notproblematic'
        end
      end

      link.save!

      expect(link.slug).to eq 'notproblematic'
    end
  end
end
