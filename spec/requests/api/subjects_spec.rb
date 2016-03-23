RSpec.describe 'Subjects API' do
  it_behaves_like 'name-description resource',
    resource: 'subjects',
    factory_name: :subject,
    model: Subject
end