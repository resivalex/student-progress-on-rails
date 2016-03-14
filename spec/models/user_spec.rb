describe User do
  context "in admin role" do
    subject do
      FactoryGirl.build :admin
    end

    it { should be_admin }
    it { should_not be_teacher }
  end

  context "in teacher role" do
    subject do
      FactoryGirl.build :teacher
    end

    it { should be_teacher }
    it { should_not be_admin }
  end

  describe 'convertion to API format' do
    user = FactoryGirl.build :user
    subject do
      user.to_api
    end

    its([:id]) { should eq user.id }
    its([:firstName]) { should eq user.first_name }
    its([:lastName]) { should eq user.last_name }
    its([:patronymic]) { should eq user.patronymic }
    its([:login]) { should eq user.login }
    its([:password]) { should eq user.password }
    its([:role]) { should eq user.role }
    its([:email]) { should eq user.email }
    its([:phone]) { should eq user.phone }
  end

  describe 'initialization from API format' do
    user = FactoryGirl.build :user
    data = user.to_api
    subject do
      User.new.from_api data
    end

    its(:first_name) { should eq data[:firstName] }
  end

  describe '.students_by_group' do
    let(:student) { FactoryGirl.create :student }

    it 'one students in first group' do
      expect(User.students_by_group(student.group.id).size).to eq 1
    end
  end
end