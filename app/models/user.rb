class User < ActiveRecord::Base
  ROLES = %w(admin chief student teacher)

  has_many :lessons

  validates :first_name, :last_name, :patronymic, :role, :email, :phone,
            presence: true
  validates :first_name, :last_name, :patronymic, length: { maximum: 25 }
  # validates :password, length: { in: 6..16 }
  validates :role, inclusion: { in: ROLES }
  validates :email, uniqueness: { case_sensitive: false }, length: { maximum: 40 },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone , length: { maximum: 25 },
            format: { with: /(\d.*){5,}/, message: 'contains less than 5 digits'}

  scope :students, -> { where(role: 'student') }
  scope :teachers, -> { where(role: 'teacher') }

  has_secure_password

  def admin?
    role == 'admin'
  end

  def teacher?
    role == 'teacher'
  end

  def chief?
    role == 'chief'
  end

  def student?
    role == 'student'
  end

  def to_api
    {
      id: id,
      firstName: first_name,
      lastName: last_name,
      patronymic: patronymic,
      role: role,
      email: email,
      phone: phone
    }
  end

  def from_api data
    send :first_name=, data[:firstName]
    send :last_name=, data[:lastName]
    send :patronymic=, data[:patronymic]
    if data[:password].present?
      send :password=, data[:password]
    end
    send :role=, data[:role]
    send :email=, data[:email]
    send :phone=, data[:phone]
    self
  end

  def self.students_by_group group_id
    User.joins('JOIN students ON users.id = students.user_id').where('students.group_id = ?', group_id)
  end

  def self.teacher_by_id id
    teachers.find_by_id id
  end

  def self.student_by_id id
    students.find_by_id id
  end

private

  def only_full_name
    {
      id: id,
      firstName: first_name,
      lastName: last_name,
      patronymic: patronymic
    }
  end
end