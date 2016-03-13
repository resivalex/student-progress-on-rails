require 'rails_helper.rb'

describe 'Auditories API' do
  include_examples 'name-description resource', {
    resource: 'auditories',
    factory_name: :auditory,
    model: Auditory
  }
end