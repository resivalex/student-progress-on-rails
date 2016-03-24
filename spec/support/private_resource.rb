RSpec.shared_examples 'private resource' do
  it { expect(response).to be_unauthorized }
  it { expect(response.body).to eq 'Unathorized' }
end