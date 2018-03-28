class Answer < ApplicationRecord

  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true
end
