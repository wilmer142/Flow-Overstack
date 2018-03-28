class Question < ApplicationRecord

	belongs_to :user
	has_many :answers, dependent: :destroy
	has_many :votes, as: :voteable, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy

	validates :title, :description, presence: true

end
