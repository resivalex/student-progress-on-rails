describe User do
  context "in admin role" do
    subject do
      FactoryGirl.build :admin
    end

    it { is_expected.to be_admin }
    it { is_expected.not_to be_teacher }
  end

  context "in teacher role" do
    subject do
      FactoryGirl.build :teacher
    end

    it { is_expected.to be_teacher }
    it { is_expected.not_to be_admin }
  end
end