# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
3.0.2

* Rails version
6.1.4.1

* System dependencies

* Configuration
Using RVM:

.ruby-version: 3.0.2
.ruby-gemset: backend_challenge

* Database creation
Actually using SQLITE.

* Database initialization
rails db:setup

In case of failure:
rails db:drop
rails db:create
rails db:migrate
rails db:seed

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)
merchants_disburse every mondays

* API

- http://localhost:3000/api/v1/disbursements
- http://localhost:3000/api/v1/disbursements?merchant={merchant_id}
- http://localhost:3000/api/v1/disbursements?week={integer(1..last_year_week).year | yyyy-mm-dd | dd-mm-yyyy | dd/mm/yyyy | yyyy/mm/dd}
- http://localhost:3000/api/v1/disbursements?merchant={merchant_id}&week={integer(1..last_year_week).year | yyyy-mm-dd | dd-mm-yyyy | dd/mm/yyyy | yyyy/mm/dd}

Example:
- http://localhost:3000/api/v1/disbursements?week=12.2018
- http://localhost:3000/api/v1/disbursements?week=20-03-2018
- http://localhost:3000/api/v1/disbursements?merchant=1
- http://localhost:3000/api/v1/disbursements?merchant=14&week=20/03/2018

* Deployment instructions
In a rails console you can generate some examples of disbursements like this:

{merchant_object}.disburse({week_number}, {year : default_current_year})
{merchant_object}.disburse({date : object | string_format})

Example:
Merchant.last.disburse(14, 2018)
Merchant.last.disburse(Date.new(2018, 3, 20))
Merchant.last.disburse('2018-03-20')

run rails server:
rails s

* ...
