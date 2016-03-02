describe 'database tables' do
  before do
    visit '/admin/tables'
  end

  let :admin_user do
    FactoryGirl.create :user, role: 'admin'
  end

  let :not_admin_user do
    FactoryGirl.create :user, role: 'student'
  end
end