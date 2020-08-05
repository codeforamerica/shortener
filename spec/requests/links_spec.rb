require "rails_helper"

RSpec.describe "Links API", type: :request do
  let(:link) { Link.create! url: 'https://codeforamerica.org', description: 'website' }

  before do
    allow(Rails.application.secrets).to receive(:shortener_api_key).and_return('SECRET')
  end

  describe "POST /links" do
    it "creates a new link" do
      post links_path, params: {
        url: "https://www.codeforamerica.org",
        description: 'Website',
        api_key: 'SECRET'
      }

      expect(response).to have_http_status(:created)
      json_body = JSON.parse(response.body, symbolize_names: true)

      expect(json_body).to include(
                             url: "https://www.codeforamerica.org"
                           )

      link = Link.last
      expect(link).to be_present
      expect(link).to have_attributes(
                        url: "https://www.codeforamerica.org",
                        description: 'Website'
                      )
    end

    context 'when API key is invalid' do
      it 'will reject them' do
        post links_path, params: {
          url: "https://www.codeforamerica.org"
        }
        expect(response).to have_http_status(:unauthorized)

        post links_path, params: {
          url: "https://www.codeforamerica.org",
          api_key: 'bad'
        }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /links/:slug' do
    it 'shows information about the link' do
      get link_path(link, api_key: 'SECRET')

      expect(response).to have_http_status(:ok)
      json_body = JSON.parse(response.body, symbolize_names: true)

      expect(json_body).to include(
                             slug: link.slug,
                             description: link.description,
                           )
    end

    context 'when API key is invalid' do
      it 'will reject them' do
        get link_path(link)
        expect(response).to have_http_status(:unauthorized)

        get link_path(link, api_key: 'bad')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /:slug' do
    it "redirects to the link url" do
      get shortened_link_path(link)
      expect(response).to redirect_to(link.url)
    end

    it "increments the counter" do
      expect do
        get shortened_link_path(link)
      end.to change { link.reload.uses_count }.from(0).to(1)

      expect(link.first_used_at).to be_within(1.second).of(Time.current)
      expect(link.last_used_at).to be_within(1.second).of(Time.current)
    end

    it "stores first and last_used_at when accessed" do
      expect do
        get shortened_link_path(link)
      end.to change { link.reload.first_used_at }.from(nil).to be_within(1.second).of(Time.current)

      expect do
        get shortened_link_path(link)
      end.not_to(change { link.reload.first_used_at })

      expect do
        get shortened_link_path(link)
      end.to(change { link.reload.last_used_at })
    end

    it "generates a 404 for nonexistant links" do
      get "/MISSING"

      expect(response).to have_attributes(
                            body: match(/sorry/i),
                            status: 404
                          )
    end
  end
end
