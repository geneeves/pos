require 'active_record'

require './lib/product'
require './lib/cashier'
require './lib/sale'
require './lib/purchase'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the 7-11 POS system"
  main_menu
end

def main_menu 
  choice = nil
  until choice == 'x'
    puts "[P]roduct Menu, [C]ashier Menu, [R]ing up a purchase, e[X]it"
    choice = gets.chomp.downcase
    case choice
    when 'p'
      product_menu
    when 'c'
      cashier_menu
    when 'r'
      sale_menu
    when 'x'
      puts 'Thank you come again.'
    else 
      puts 'That was not a valid option'
    end
  end
end

# PRODUCT STUFF


def product_menu
  puts "[A]dd a product, [L]ist products, [U]pdate a product name or price, [R]emove a product, [M]ain menu"
  choice = gets.chomp.downcase
  case choice
  when 'a'
    add_product
  when 'l'
    list_products
  when 'u'
    update_product
  when 'r'
    remove_product
  when 'm'
    main_menu
  else 
    puts "Please enter valid option"
  end
end

def add_product
  puts "Please enter a product name."
  product_name = gets.chomp
  puts "Please enter the price of this product."
  product_price = gets.chomp
  product = Product.create(:name => product_name, :price => product_price)
  puts "Your product: #{product.name} has been saved with a price of $#{product.price}"
end

def list_products
  puts "============= 7 - 11 PRODUCTS ==========="
  Product.all.each_with_index { |product| puts "ID: #{product.id}.   #{product.name}       $#{product.price}" }
end 

def remove_product
  puts "Select the product you want to delete."
  list_products
  selection = gets.chomp.to_i
  Product.find(selection).destroy
  puts "Item deleted." 
end

def update_product
  puts "Select the product you want to delete."
  list_products
  selection = gets.chomp.to_i
  puts "Update [n]ame or [p]rice"
  choice = gets.chomp.downcase
  case choice
    when 'n'
      puts "Enter the new name"
      new_name = gets.chomp
      Product.find(selection).update(:name => new_name)
      puts "Updated."
    when 'p'
      puts "Enter the new price"
      new_price = gets.chomp.to_i
      Product.find(selection).update(:price => new_price)
      puts "Updated price."
    else 
      puts "Valid option please."
  end
end


# CASHIER STUFF

def cashier_menu
  puts "[A]dd a cashier, [Li]st cashiers, [U]pdate a cashier name or price, [R]emove a cashier, [M]ain menu"
  choice = gets.chomp.downcase
  case choice
  when 'a'
    add_cashier
  when 'li'
    see_cashiers
  when 'u'
    update_cashier
  when 'r'
    remove_cashier
  when 'm'
    main_menu
  else 
    puts "Please enter valid option"
  end
end


def add_cashier
  puts "Please enter the name of the cashier to be added."
  cashier_name = gets.chomp
  puts "Enter a four digit PIN for the cashier"
  cashier_pin = gets.chomp.to_i
  cashier = Cashier.create(:name => cashier_name, :pin => cashier_pin)
  if cashier.save 
    puts "#{cashier.name} has been added. This cashier's pin is #{cashier.pin}"
  else 
    cashier.errors.full_messages.each {|message| puts message}
  end
end

def see_cashiers
  puts "Here are all of your cashiers:"
  Cashier.all.each { |cashier| puts "#{cashier.name}" }
end


# SALE MENU
def sale_menu
  puts "[S]ale to make a sale, [M]ain menu"
  choice = gets.chomp.downcase
  case choice
  when 's'
    make_sale
  when 'm'
    main_menu
  else 
    puts "Not a valid entry."
  end
end

def make_sale
  puts "Cashier: enter your PIN to log in."
  pin = gets.chomp.to_i
  cashier = Cashier.where(:pin => pin).first
  if cashier.nil?
    puts "PIN Not valid, try again."
  else
    list_products
    puts "Enter the product id:"
    product_id = gets.chomp.to_i
    product = Product.find(product_id)
    puts "Enter the quantity of #{product.name} the customer is buying"
    quantity = gets.chomp.to_i
    sale = Sale.create(:cashier_id => cashier.id)
    purchase = Purchase.create(:sale_id => sale.id, :product_id => product.id, :quantity => quantity)
    puts "Purchase number #{purchase.id} complete."
  end 
end

welcome


