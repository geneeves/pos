class Sale <ActiveRecord::Base
  belongs_to :cashier
  has_many :purchases
  has_many :products, through: :purchases 

  def total
    self.purchases.each do |product|
      purchase.product.price * purchase.quantity
    end
  end
end
