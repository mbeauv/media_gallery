class User < ApplicationRecord
  has_many :galleries, as: :ownable
end
