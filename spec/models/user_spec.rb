describe User do
  context "in admin role" do
    subject do
      FactoryGirl.build :user, role: 'admin'
    end

    it { is_expected.to be_admin }
    it { is_expected.not_to be_teacher }
  end

  context "in teacher role" do
    subject do
      FactoryGirl.build :user, role: 'teacher'
    end

    it { is_expected.to be_teacher }
    it { is_expected.not_to be_admin }
  end
end