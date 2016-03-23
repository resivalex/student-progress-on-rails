RSpec.describe 'Auditories API' do
  it_behaves_like 'name-description resource',
    resource: 'auditories',
    factory_name: :auditory,
    model: Auditory
end