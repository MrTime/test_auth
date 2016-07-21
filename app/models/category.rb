class Category < ActiveRecord::Base
  acts_as_nested_set

  #belongs_to :parent, class_name: 'Category'
  #has_many :children, class_name: 'Category', foreign_key: 'parent_id'

  #scope :roots, -> { where(parent: nil) }
  #scope :sorted, -> { order(position: :asc) }

  #default_scope { sorted }
end
