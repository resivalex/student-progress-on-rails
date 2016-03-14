require 'rails_helper.rb'

tables = %w[users lessons marks mark_tracks]

describe Admin::TablesController do
  render_views

  let :login_as do
    lambda do |user_factory|
      cookies[:user_id] = (FactoryGirl.create user_factory).id
    end
  end

  context 'nonadmin' do
    render_views

    it "redirects to '/'" do
      login_as.call :student
      get :index

      expect(response).to redirect_to '/'
    end
  end

  context 'admin' do
    before do
      login_as.call :admin
    end

    it "renders tables '#{tables}'" do
      get :index
      tables.each do |table|
        expect(response.body).to match table
      end
    end

    context "one mark track" do
      mark_track = FactoryGirl.create :mark_track

      subject do
        get :index
        response.body
      end

      it { should match mark_track.name }
      it { should match mark_track.comment }
    end

    context "one user" do
      before :all do
        @us = FactoryGirl.create :user
      end

      after :all do
        @us.destroy
      end

      subject do
        get :index
        response.body
      end

      it { should match @us.email }
      it { should match @us.first_name }
      it { should match @us.last_name }
      it { should match @us.login }
      it { should match @us.phone }
    end

    context "one lesson" do
      before do
        @lesson = FactoryGirl.create :lesson
      end

      subject do
        get :index
        response.body
      end

      it "contains lesson time" do
        should match @lesson.time.to_s
      end
    end
  end
end