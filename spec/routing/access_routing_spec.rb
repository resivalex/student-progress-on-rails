require "rails_helper.rb"

describe '/admin/* path', type: :request do
  paths = %w(/admin/tables /admin/wepriasdf /admin)
  paths.each do |path|
    it "#{path} should redirects nonadmin users to '/'" do
      user = FactoryGirl.create :user, role: 'student'
      get path
      expect(response).to redirect_to '/'
    end
  end
end
