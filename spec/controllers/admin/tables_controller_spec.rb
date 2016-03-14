# require 'rails_helper.rb'

# tables = %w[users lessons marks mark_tracks]

# describe Admin::TablesController do
#   render_views

#   let :login_as do
#     lambda do |user_factory|
#       cookies[:user_id] = (FactoryGirl.create user_factory).id
#     end
#   end

#   context 'nonadmin' do
#     render_views

#     it "redirects to '/'" do
#       login_as.call :student_user
#       get :index

#       expect(response).to redirect_to '/'
#     end
#   end

#   context 'admin' do
#     before do
#       login_as.call :admin
#     end

#     it "renders tables '#{tables}'" do
#       get :index
#       tables.each do |table|
#         expect(response.body).to match table
#       end
#     end

#     context "one mark track" do
#       mark_track = FactoryGirl.create :mark_track

#       subject do
#         get :index
#         response.body
#       end

#       it { should match mark_track.name }
#       it { should match mark_track.comment }
#     end

#     context "one user" do
#       let(:user) { FactoryGirl.create :user }

#       subject do
#         get :index
#         response.body
#       end

#       it { should match user.email }
#       it { should match user.first_name }
#       it { should match user.last_name }
#       it { should match user.login }
#       it { should match user.phone }
#     end

#     context "one lesson" do
#       let(:lesson) { FactoryGirl.create :lesson }

#       subject do
#         get :index
#         response.body
#       end

#       it "contains lesson time" do
#         should match lesson.time.to_s
#       end
#     end
#   end
# end