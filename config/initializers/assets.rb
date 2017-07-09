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
      "#{controller}.coffee",
      "#{controller}.js.coffee",
      "#{controller}.css"
  ]
  Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
end
