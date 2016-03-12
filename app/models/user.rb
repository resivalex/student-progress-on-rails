class User < ActiveRecord::Base
  ROLES = %w(admin chief student teacher)

  validates :first_name, :last_name, :patronymic, :login, :password, :role, :email, :phone,
            presence: true
  validates :first_name, :last_name, :patronymic, length: { maximum: 25 }
  validates :login, uniqueness: true, length: { in: 3..16 }
  validates :password, length: { in: 6..16 }
  validates :role, inclusion: { in: ROLES }
  validates :email, uniqueness: { case_sensitive: false }, length: { maximum: 40 },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone , length: { maximum: 25 },
            format: { with: /(\d.*){5,}/, message: 'contains less than 5 digits'}

  def admin?
    role == 'admin'
  end

  def teacher?
    role == 'teacher'
  end

  def to_api
    {
      id: id,
      firstName: first_name,
      lastName: last_name,
      patronymic: patronymic,
      login: login,
      password: password,
      role: role,
      email: email,
      phone: phone
    }
  end

  def from_api data
    send :first_name=, data[:firstName]
    send :last_name=, data[:lastName]
    send :patronymic=, data[:patronymic]
    send :login=, data[:login]
    send :password=, data[:password]
    send :role=, data[:role]
    send :email=, data[:email]
    send :phone=, data[:phone]
    self
  end
end