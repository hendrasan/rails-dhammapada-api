class Chapter < ApplicationRecord
  validates :title, presence: true

  has_many :verses, dependent: :destroy
end
