describe 'root page' do
  it 'is greeting user' do
    visit '/'
    expect(page).to have_content 'Welcome'
  end

  it 'has link to login page' do
    visit '/'
    click_link 'Sign in'
    expect(page.current_path).to eql '/login'
  end
end

describe 'login page' do
  let :user do
    FactoryGirl.create :user, login: 'student', password: '123456'
  end

  it 'has login form' do
    visit '/login'
    expect(page).to have_selector 'input#login'
    expect(page).to have_selector 'input#password'
    expect(page).to have_selector 'input[type=submit]'
  end

  it 'passes existing user' do
    visit '/login'
    fill_in 'login', with: user.login
    fill_in 'password', with: user.password
    click_button 'Log in'
    expect(page.current_path).to eql '/'
    expect(page).to have_content 'Success!'
  end

  it 'shows warning about wrong login data' do
    visit '/login'
    fill_in 'login', with: user.login
    fill_in 'password', with: user.password + '0'
    click_button 'Log in'
    expect(page.current_path).to eql '/login'
    expect(page).to have_content 'You are wrong. Try again.'
  end
end