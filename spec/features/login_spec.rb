describe 'login page' do
  before do
    visit '/login'
  end

  let :user do
    FactoryGirl.create :user, login: 'student', password: '123456'
  end

  describe 'login form' do
    subject { page }

    it { is_expected.to have_selector 'input#login' }
    it { is_expected.to have_selector 'input#password' }
    it { is_expected.to have_selector 'input[type=submit]'}
  end

  context 'right login/password pair' do
    subject do
      fill_in 'login', with: user.login
      fill_in 'password', with: user.password
      click_button 'Log in'
      page
    end

    it { expect(subject.current_path).to eql '/' }
    it { is_expected.to have_content 'Success!' }
  end

  context 'wrong login/password pair' do
    subject do
      fill_in 'login', with: user.login
      fill_in 'password', with: user.password + '0'
      click_button 'Log in'
      page
    end

    it { expect(subject.current_path).to eql '/login' }
    it { is_expected.to have_content 'You are wrong. Try again.' }
  end
end