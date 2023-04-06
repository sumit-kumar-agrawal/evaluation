module Blending
  extend ActiveSupport::Concern

  included do
    after_save :make_juice, if: Proc.new{ |record| record.class.name == 'Apple' }
  end

  # -------------------------------------------------------------
  #
  def make_juice
    puts "Make juice from #{self.class.name}"
  end

end