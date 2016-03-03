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
end