class Basket < ApplicationRecord
  #------------------------Associations-----------------------------------
  has_many :apples

  #------------------------Callbacks-----------------------------------
  after_save :update_fill_rate

  private

  def update_fill_rate
    self.update_column(:fill_rate, "#{(self.apples.count * 100.0 / self.capacity).round}%")
  end

end
