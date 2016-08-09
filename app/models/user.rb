class User < ActiveRecord::Base
	has_many :comments
	has_many :articles
	before_save :downcase_email
	validates :name, :email, presence: true
	validates :email, uniqueness: { case_sensitive: false }, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password

	def downcase_email
		self.email = self.email.downcase
	end

end
