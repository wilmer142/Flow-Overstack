class Question < ApplicationRecord

	validates :title, :description, presence: true

end
