class Cashier <ActiveRecord::Base
  validates :pin, uniqueness: true
end
