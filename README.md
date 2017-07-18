# README

This is a project for shopping cart and background management system which includes product, user, order, purchase, sale, inventory, and sale platform.

* Ruby version : `~> 2.3.0`

* System dependencies

  payment : [active_merchant_pay2go](https://github.com/imgarylai/active_merchant_pay2go) (This is a thirdparty payment system in Taiwan)

  image's place for production : `Amazon s3`



* Configuration

  rename `application.example.yml` to `application.yml`

  And use your own key on `application.yml`

* Database creation

  This project use `PostgreSQL`

  Make sure you have `PostgreSQL` and  [HomeBrew](https://brew.sh) on your computer

  start the postgresql servise

  ```
  $ brew services start postgresql
  ```

  create a DB

  ```
  $ createdb maskstore
  ```

  rename `datebase.example.yml` to `datebase.yml`

* Database initialization

  run migration

  ```
  $ rails db:migrate
  ```

  create a default admin user

  ```
  $ rails db:seed
  ```

  Username : `admin@gmail.com`

  password : `123123`


