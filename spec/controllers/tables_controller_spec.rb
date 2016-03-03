require 'rails_helper.rb'

tables = %w[users lessons marks mark_tracks]

describe TablesController do
  render_views

  let :get_in_role do
    proc do |role|
      user = FactoryGirl.create :user, role: role
      cookies[:user_id] = user.id
      get :index
    end
  end

  it "renders tables '#{tables}'" do
    get_in_role.call 'admin'

    tables.each do |table|
      expect(response.body).to match table
    end
  end

  it "redirects nonadmin users to '/'" do
    get_in_role.call 'student'

    expect(response).to redirect_to '/'
  end

  it "displays 'mark_tracks'" do
    mark_track = FactoryGirl.create :mark_track
    get_in_role.call 'admin'

    expect(response.body).to match mark_track.name
    expect(response.body).to match mark_track.comment
  end
end