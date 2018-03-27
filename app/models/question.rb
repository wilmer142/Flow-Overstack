class Question < ApplicationRecord

	belongs_to :user
	has_many :answers
	has_many :votes, as: :voteable

	validates :title, :description, presence: true

end
