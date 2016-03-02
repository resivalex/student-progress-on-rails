describe 'root page' do
  before do
    visit '/'
  end

  it 'is greeting user' do
    expect(page).to have_content 'Welcome'
  end

  it 'has link to login page' do
    click_link 'Sign in'
    expect(page.current_path).to eql '/login'
  end
end
