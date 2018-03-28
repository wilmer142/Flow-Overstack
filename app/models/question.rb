class Question < ApplicationRecord

	belongs_to :user
	has_many :answers
	has_many :votes, as: :voteable
	has_many :comments, as: :commentable

	validates :title, :description, presence: true

end
