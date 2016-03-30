RSpec.shared_examples 'private resource' do
  it { expect(response).to be_unauthorized }
  it { expect(json['errors']).to be_present }
end