class Article < ActiveRecord::Base
	has_many :comments
	belongs_to :user
	validates :content, presence: true
	validates :title, presence: true, uniqueness: true
end
