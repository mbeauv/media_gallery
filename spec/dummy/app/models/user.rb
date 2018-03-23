class User < ApplicationRecord
  has_many :galleries, as: :ownable
  has_one :scratch, as: :ownable
end
