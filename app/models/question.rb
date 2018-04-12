# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  votes       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Question < ApplicationRecord

	belongs_to :user
	has_many :answers, dependent: :destroy
	has_many :votes, as: :voteable, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy

	validates :title, :description, presence: {message: "no puede estar vacio"}

end
