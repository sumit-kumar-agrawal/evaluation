class Apple < ApplicationRecord
  include Blending

  #------------------------Associations-----------------------------------
  belongs_to :basket, optional: true
end