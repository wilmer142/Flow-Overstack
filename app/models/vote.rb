# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  voteable_type :string
#  voteable_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

class Vote < ApplicationRecord

  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :voteable_type, :voteable_id, presence: true

  validates_uniqueness_of :user_id, scope: [:voteable_type, :voteable_id], message: "Ya tiene un voto registrado"
end
