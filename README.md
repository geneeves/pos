This is a simple POS built in Ruby with Active Record as part of
[Epicodus](http://www.epicodus.com/). It's as much about CRUDing Ruby objects and building custom methods as it was designing a succinct relational database. 

At the moment, it allows a manager or employee to add and remove products, add employees and remove employees securely, set prices, and ring up purchases. In the future, we'd like to add receipts to print out a purchase total and arrange returns on select items. 

Before running the app, run `bundle install` to install the necessary gems, `rake db:create` to
create your database, and then `rake db:schema:load` to load the database schema.

To start the app, run `ruby bin/pos_ui.rb`. There's no browser interface on this one, so have fun in command line!
