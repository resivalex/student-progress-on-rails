describe 'login page' do
  before do
    visit '/login'
  end

  let :user do
    FactoryGirl.create :student
  end

  context 'right login/password pair' do
    subject do
      fill_in 'login', with: user.login
      fill_in 'password', with: user.password
      click_button 'Log in'
      page
    end

    its(:current_path) { should eql '/' }
    it { should have_content 'Success!' }
  end

  context 'wrong login/password pair' do
    subject do
      fill_in 'login', with: user.login
      fill_in 'password', with: user.password + '0'
      click_button 'Log in'
      page
    end

    its(:current_path) { should eql '/login' }
    it { should have_content 'You are wrong. Try again.' }
  end
end