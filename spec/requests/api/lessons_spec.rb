# require 'rails_helper.rb'

# describe 'Lessons API' do
#   it '#index' do
#     FactoryGirl.create :lesson

#     get '/lessons.json'

#     expect(response).to be_success

#     puts json
#     expect(json.length).to eq 1
#   end

#   it '#show' do
#     lesson = FactoryGirl.create :lesson
#     get "/lessons/#{lesson.id}.json"

#     expect(response).to be_success

#     expect(json['auditoryId']).to eq lesson.auditory_id
#   end

#   it '#create' do
#     lesson = FactoryGirl.build :lesson
#     data = lesson.to_api

#     post '/lessons.json', data

#     lesson = Lesson.take

#     expect(Lesson.count).to eql 1
#     expect(lesson.auditory_id).to eql data[:auditoryId]
#   end

#   it '#update' do
#     lesson = FactoryGirl.create :lesson
#     data = lesson.to_api
#     data[:firstName] += '_'

#     put "/lessons/#{lesson.id}.json", data

#     expect(lesson.count).to eql 1
#     expect(lesson.take.first_name).to eql data[:firstName]
#   end

#   it '#destroy' do
#     lesson = FactoryGirl.create :lesson

#     delete "/lessons/#{lesson.id}.json"

#     expect(lesson.count).to eql 0
#   end
# end