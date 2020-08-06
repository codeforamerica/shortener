require "rails_helper"

RSpec.describe "Root path", type: :request do
  context 'when there is NO shortener_root_redirect_url' do
    it 'displays simple text' do
      get root_path

      expect(response.body).to include "Shortener"
    end
  end

  context 'when there is shortener_root_redirect_url' do
    before do
      allow(Rails.application.secrets).to receive(:shortener_root_redirect_url).and_return 'https://example.com/somewhere'
    end

    it 'redirects to the URL' do
      get root_path
      expect(response).to redirect_to('https://example.com/somewhere')
    end
  end
end
