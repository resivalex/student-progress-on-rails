require 'rails_helper.rb'

describe 'Lessons API' do
  shared_context 'correct lesson data' do |time|
    let(:data) do
      lesson = if time
        FactoryGirl.build :lesson, time: time
      else
        FactoryGirl.build :lesson
      end
      lesson.to_api
    end
  end

  shared_context 'wrong lesson data' do
    let(:data) do
      lesson = FactoryGirl.build :lesson
      data = lesson.to_api
      data[:datetime] = 'wrong'
    end
  end

  shared_examples 'lesson record' do
    its(['id']) { should eq lesson.id }
    its(['groupId']) { should eq lesson.group_id }
    its(['teacherId']) { should eq lesson.user_id }
    its(['subjectId']) { should eq lesson.subject_id }
    its(['auditoryId']) { should eq lesson.auditory_id }
    its(['datetime']) { should eq lesson.time.iso8601 }
  end

  describe 'GET /lessons' do
    let!(:lesson) { FactoryGirl.create :lesson }

    before { get '/lessons.json' }

    it { expect(response).to be_success }
    it { expect(json.length).to eq 1 }

    subject { json[0] }
    it_behaves_like 'lesson record'
  end

  describe 'GET /lessons/:id' do
    let!(:lesson) { FactoryGirl.create :lesson }

    before { get "/lessons/#{lesson.id}.json" }

    it { expect(response).to be_success }

    subject { json }
    it_behaves_like 'lesson record'
  end

  describe 'POST /lessons' do
    context 'correct data' do
      include_context 'correct lesson data'

      before { post '/lessons.json', data }

      it { expect(Lesson.count).to eq 1 }
      it { expect(Lesson.take.auditory_id).to eq data[:auditoryId] }
    end

    context 'wrong data' do
      include_context 'wrong lesson data'

      before { post '/lessons.json', data }

      it { expect(Lesson.count).to eq 0 }
      it { expect(response).to be_bad_request }
    end
  end

  describe 'PUT /lessons/:id' do
    let!(:lesson) { FactoryGirl.create :lesson, time: (Time.new 2016, 2, 22, 15, 20) }

    context 'correct data' do
      new_time = Time.new 2016, 2, 22, 15, 30
      include_context 'correct lesson data', new_time

      before { put "/lessons/#{lesson.id}.json", data }

      it { expect(Lesson.count).to eq 1 }
      it { expect(Lesson.take.time).to eq new_time }
    end

    context 'wrong data' do
      include_context 'wrong lesson data'

      before { put "/lessons/#{lesson.id}.json", data }

      it { expect(Lesson.count).to eq 1 }
      it { expect(response).to be_bad_request }
    end
  end

  describe 'DELETE /lessons/:id' do
    let!(:lesson) { FactoryGirl.create :lesson }

    before { delete "/lessons/#{lesson.id}.json" }

    it { expect(Lesson.count).to eq 0 }
  end
end