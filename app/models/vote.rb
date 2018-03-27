class Vote < ApplicationRecord

  belongs_to :voteable, polymorphic: true

  validates :voteable_type, :voteable_id, presence: true

  validates_uniqueness_of :user_id, scope: [:voteable_type, :voteable_id], message: "Ya tiene un voto registrado"
end
