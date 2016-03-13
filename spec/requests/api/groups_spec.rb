require 'rails_helper.rb'

describe 'Groups API' do
  include_examples 'name-description resource', {
    resource: 'groups',
    factory_name: :group,
    model: Group
  }

  describe '/groups/:id/students' do
    include_context '3 students in 2 groups'

    it 'wrong group id' do
      get '/groups/wrong_id/students.json'

      expect(response).to be_not_found
    end

    it 'group with one student' do
      get "/groups/#{@groups[0].id}/students.json"

      expect(json.length).to eq 1
    end

    it 'group with two students' do
      get "/groups/#{@groups[1].id}/students.json"

      expect(json.length).to eq 2
    end
  end
end
