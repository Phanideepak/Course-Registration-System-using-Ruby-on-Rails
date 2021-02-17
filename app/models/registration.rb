class Registration < ApplicationRecord
	validates :c_id, presence: true
	validates :s_id, presence:true
	validates :c_id, :uniqueness => {:scope => :s_id}
	validates :grade, numericality: { only_integer: true, :less_than_or_equal_to => 10}
end
