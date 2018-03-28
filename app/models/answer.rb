class Answer < ApplicationRecord

  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable

  validates :content, presence: true
end
