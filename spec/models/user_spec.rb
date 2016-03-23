RSpec.describe User do
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

    its([:id])         { should eq user.id }
    its([:firstName])  { should eq user.first_name }
    its([:lastName])   { should eq user.last_name }
    its([:patronymic]) { should eq user.patronymic }
    its([:role])       { should eq user.role }
    its([:email])      { should eq user.email }
    its([:phone])      { should eq user.phone }
  end

  describe 'initialization from API format' do
    let(:data) do
      FactoryGirl.build(:user).to_api
    end

    subject { User.new.from_api data }

    its(:first_name) { should eq data[:firstName] }
    its(:last_name)  { should eq data[:lastName] }
    its(:patronymic) { should eq data[:patronymic] }
    its(:password)   { should eq data[:password] }
    its(:role)       { should eq data[:role] }
    its(:email)      { should eq data[:email] }
    its(:phone)      { should eq data[:phone] }
  end

  describe '.students_by_group' do
    let(:student) { FactoryGirl.create :student }

    context 'one students in first group' do
      subject { User.students_by_group(student.group_id) }
      its(:size) { should eq 1 }
    end
  end
end