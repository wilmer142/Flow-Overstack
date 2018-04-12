# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  description      :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable_type, :commentable_id, :user_id, :description, presence: {message: "Comentario no puede ser vacio"}
end
