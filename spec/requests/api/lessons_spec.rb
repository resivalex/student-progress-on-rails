require 'rails_helper.rb'

describe 'Lessons API' do
  it '#index' do
    FactoryGirl.create :lesson

    get '/lessons.json'

    expect(response).to be_success

    expect(json.length).to eq 1
  end

  it '#show' do
    lesson = FactoryGirl.create :lesson
    get "/lessons/#{lesson.id}.json"

    expect(response).to be_success

    expect(json['auditoryId']).to eq lesson.auditory_id
  end

  it '#create' do
    lesson = FactoryGirl.build :lesson
    data = lesson.to_api

    post '/lessons.json', data

    lesson = Lesson.take

    expect(Lesson.count).to eql 1
    expect(lesson.auditory_id).to eql data[:auditoryId]
  end

  it '#update' do
    time1 = Time.new 2016, 2, 22, 15, 20
    time2 = Time.new 2016, 2, 22, 15, 30
    lesson1 = FactoryGirl.create :lesson, time: time1
    lesson2 = FactoryGirl.build :lesson, time: time2
    data = lesson2.to_api

    put "/lessons/#{lesson1.id}.json", data

    expect(Lesson.count).to eql 1
    expect(Lesson.take.time).to eql time2
  end

  it '#destroy' do
    lesson = FactoryGirl.create :lesson

    delete "/lessons/#{lesson.id}.json"

    expect(Lesson.count).to eql 0
  end
end