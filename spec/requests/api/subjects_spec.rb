require 'rails_helper.rb'

describe 'Subjects API' do
  include_examples 'name-description resource', {
    resource: 'subjects',
    factory_name: :subject,
    model: Subject
  }
end