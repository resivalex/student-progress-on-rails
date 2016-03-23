RSpec.describe Auditory do
  describe 'convertion to API format' do
    let!(:auditory) { FactoryGirl.build :auditory }

    subject { auditory.to_api }

    its([:id])          { should eq auditory.id }
    its([:name])        { should eq auditory.name }
    its([:description]) { should eq auditory.description }
  end

  describe 'initialization from API format' do
    auditory = FactoryGirl.build :auditory
    data = auditory.to_api
    subject do
      Auditory.new.from_api data
    end

    its(:name)          { should eq data[:name] }
    its(:description)   { should eq data[:description] }
  end
end