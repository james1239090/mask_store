# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.


%w(account/orders admin/inventories admin/orders admin/photos admin/product_oprtions
   admin/products admin/purchases admin/sale_platforms admin/sales admin/users
   admin cart_items carts orders products).each do |controller|
  Rails.application.config.assets.precompile += [
    "#{controller}.js",
    "#{controller}.css",
  ]
end
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/


# Rails.application.config.assets.precompile += %w(
#     account/orders.js account/orders.css admin/products.js admin/products.css
#     products.js products.css
#     *.ttf *.svg *.eot *.woff
#     *.png *.gif *.jpg *.jpeg )
