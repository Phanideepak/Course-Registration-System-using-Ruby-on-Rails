class Course < ApplicationRecord
	validates :name, presence: true, :uniqueness => true
	validates :credits, presence: true
	validates :admin, presence: true
end
