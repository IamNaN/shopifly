# README

This is intended to be a simple-to-integrate shopping cart module. It is not related to nor competes with Shopify in any way. It comes as a result of trying to create a shopping cart in another application but it quickly became too complicated to manage in the same code base.

The idea is that you can add the module (that will eventually become a gem) and simply add "has_cart" to whatever module you like (for instance User) and add "is_cartable" to the models you would like to be containable in the cart. The rest is taken care of by the module.

`has_cart` adds new methods to the User (etc) model, namely `cart`, which will return the active cart, creating it if necessary. A User can have multiple carts, but there is only one `current_cart`, the rest are essentially archived carts, have gone through "check out". This acts as an history of previous purchases.

`is_cartable` doesn't add any methods to the cartable class, but requires adding an `available` method that returns a count of available inventory or false if none are available. It also requires adding `lock` as discussed later.`is_cartable` can be added to any number of disparate classes. For instance, a school might use the cart for class registrations, merchandise, and charitable donations (as we have).

As mentioned, it add the `cart` method, which returns a Cart model. In typical use, you might do something like `current_user.cart.add(widget)`. Cart has other important methods. `release` removes items from the cart that are no longer available for whatever reason. `reserve` calls the same method on the cartable model to hold one or more items. The reserveration may be released later. The intent here is to hold items as the user enters check-out. There is a configurable timeout on the lock. And finally `lock` which makes the reservation permanent. Reserverations and locks are checked against `available` and wrapped in transactions to ensure availability and be atomic.

**This project is not ready to be used, nor am I accepting contributions at this time.**
