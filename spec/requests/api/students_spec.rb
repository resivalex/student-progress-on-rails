require 'rails_helper.rb'

describe 'Subjects API' do
  include_context '2 students, admin and teacher'

  it '#index' do
    get '/students.json'
    expect(json.length).to eq 2
    ids = [json[0]['id'], json[1]['id']]

    expect(ids).to include @student1.id
    expect(ids).to include @student2.id
  end

  describe '#show' do
    it 'existing student' do
      get "/students/#{@student1.id}"

      expect(response).to be_success
      expect(json['firstName']).to eq @student1.first_name
    end

    it 'not student' do
      get "/students/#{@admin.id}"

      expect(response).to be_not_found
    end
  end
end
