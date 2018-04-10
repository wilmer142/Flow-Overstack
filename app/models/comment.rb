class Comment < ApplicationRecord
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :commentable_type, :commentable_id, :user_id, :description, presence: {message: "Comentario no puede ser vacio"}
end
