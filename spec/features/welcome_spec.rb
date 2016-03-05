describe 'root page' do
  before { visit '/' }

  subject { page }

  it 'is greeting user' do
    should have_content 'Welcome'
  end

  context 'clicked link to login page' do
    before { click_link 'Sign in' }

    its(:current_path) { should eql '/login' }
  end
end
