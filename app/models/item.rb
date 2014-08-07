class Item < ActiveRecord::Base
  attr_accessible :name, :parent
  has_ancestry
  validates :name, presence: true
end
