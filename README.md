# README

# Backend coding challenge

This is the coding challenge for people who applied to a backend developer position at The Company. It's been designed to be a simplified version of the same problems we deal with.

## The challenge

The Company provides ecommerce shops (merchants) a flexible payment method so their customers (shoppers) can purchase and receive goods without paying upfront. The Company earns a small fee per purchase and pays out (disburse) the merchant once the order is marked as completed.

The operations manager is now asking you to make a system to calculate how much money should be disbursed to each merchant based on the following rules:

* Disbursements are done weekly on Monday.
* We disburse only orders which status is completed.
* The disbursed amount has the following fee per order:
  * 1% fee for amounts smaller than 50 €
  * 0.95% for amounts between 50€ - 300€
  * 0.85% for amounts over 300€

We expect you to:

* Create the necessary data structures and a way to persist them for the provided data. You don't have to follow our schema if you think another one suits better.
* Calculate and persist the disbursements per merchant on a given week. As the calculations can take some time it should be isolated and be able to run independently of a regular web request, for instance by running a background job.
* Create an API endpoint to expose the disbursements for a given merchant on a given week. If no merchant is provided return for all of them.

Find attached the merchants, shopper and orders in /db/examples in json format. They follow this structure:

### MERCHANTS

```
ID | NAME                      | EMAIL                             | CIF
1  | Treutel, Schumm and Fadel | info@treutel-schumm-and-fadel.com | B611111111
2  | Windler and Sons          | info@windler-and-sons.com         | B611111112
3  | Mraz and Sons             | info@mraz-and-sons.com            | B611111113
4  | Cummerata LLC             | info@cummerata-llc.com            | B611111114
```

### SHOPPERS

```
ID | NAME                 | EMAIL                              | NIF
1  | Olive Thompson       | olive.thompson@not_gmail.com       | 411111111Z
2  | Virgen Anderson      | virgen.anderson@not_gmail.com      | 411111112Z
3  | Reagan Auer          | reagan.auer@not_gmail.com          | 411111113Z
4  | Shanelle Satterfield | shanelle.satterfield@not_gmail.com | 411111114Z
```

### ORDERS

```
ID | MERCHANT ID | SHOPPER ID | AMOUNT | CREATED AT           | COMPLETED AT
1  | 25          | 3351       | 61.74  | 01/01/2017 00:00:00  | 01/07/2017 14:24:01
2  | 13          | 2090       | 293.08 | 01/01/2017 12:00:00  | nil
3  | 18          | 2980       | 373.33 | 01/01/2017 16:00:00  | nil
4  | 10          | 3545       | 60.48  | 01/01/2017 18:00:00  | 01/08/2017 15:51:26
5  | 8           | 1683       | 213.97 | 01/01/2017 19:12:00  | 01/08/2017 14:12:43
```

## Instructions

* Please read carefully the challenge and if you have any doubt or need extra info please don't hesitate to ask us before starting.
* You shouldn't spend more than 3h on the challenge.
* Design, test, develop and document the code. It should be a performant, clean and well structured solution. Then send us a link or a zip with a git repo.
* You should consider this code ready for production as it were a PR to be reviewed by a colleague. Also commit as if it were a real assignment.
* Remember you're dealing with money, so you should be careful with related operations.
* Create a README explaining how to setup and run your solution and a short explanation of your technical choices, tradeoffs, ...
* You don't need to finish. We value quality over feature-completeness. If you have to leave things aside you can mention them on the README explaining why and how you would resolve them.
* You can code the solution in a language of your choice, here are some technologies we are more familiar with (no particular order): JavaScript, Ruby, Python, Go, Elixir, Java, Scala, PHP.
* Your experience level will be taken into consideration when evaluating.

# Things you may want to cover:

* ## Ruby version

  3.0.2
* ## Rails version

  6.1.4.1
* ## Using RVM:

  `.ruby-version: 3.0.2`
  `.ruby-gemset: backend_challenge`
* ## Dependencies

  Sidekiq (for background jobs)
  Redis (for sidekiq web interface)
* ## Database creation

  Actually using SQLITE.
* ## Database initialization


  ```
  rails db:setup
  ```

  ### In case of failure:

  ```
  rails db:drop
  rails db:create
  rails db:migrate
  rails db:seed
  ```
* ## Test suite

  RSpec
  Factory Bot
  Faker
  Shoulda Matchers

  ### Run battery of tests


  ```
  bundle exec rspec
  ```
* ## Services (job queues, cache servers, engines)

  A new rake task has been created to run all the jobs on Sidekiq (jobs:run).


  ### Run redis

  ```
  redis-server
  ```

  ### Run sidekiq

  ```
  sidekiq
  ```

  ### Run MerchantsDisburseJob every mondays on Sidekiq

  ```
  rake jobs:run
  ```

  ### Engine Sidekiq::Web '/jobs' for admin jobs

  ```
  http://localhost:3000/jobs
  ```
* ## API

  `http://localhost:3000/api/v1/disbursements`

  `http://localhost:3000/api/v1/disbursements?merchant={merchant_id}`

  `http://localhost:3000/api/v1/disbursements?week={integer(1..last_year_week).year | yyyy-mm-dd | dd-mm-yyyy | dd/mm/yyyy | yyyy/mm/dd}`

  `http://localhost:3000/api/v1/disbursements?merchant={merchant_id}&week={integer(1..last_year_week).year | yyyy-mm-dd | dd-mm-yyyy | dd/mm/yyyy | yyyy/mm/dd}`

  ### Example

  `http://localhost:3000/api/v1/disbursements?week=12.2018`
  `http://localhost:3000/api/v1/disbursements?week=20-03-2018`
  `http://localhost:3000/api/v1/disbursements?merchant=1`
  `http://localhost:3000/api/v1/disbursements?merchant=14&week=20/03/2018`
* ## Deployment instructions

  In a rails console you can generate some examples of disbursements like this:


  ```
  rails c
  ```

  ```
  {merchant_object}.disburse({week_number}, {year : default_current_year})
  {merchant_object}.disburse({date : object | string_format})
  ```

  ### Example

  `Merchant.last.disburse(14, 2018) `
  `Merchant.last.disburse(Date.new(2018, 3, 20))`
  `Merchant.last.disburse('2018-03-20')`

  ## Run rails server

  ```
  rails s
  ```

# Rails stats

```
+----------------------+--------+--------+---------+---------+-----+-------+
| Name                 |  Lines |    LOC | Classes | Methods | M/C | LOC/M |
+----------------------+--------+--------+---------+---------+-----+-------+
| Controllers          |     19 |     16 |       3 |       2 |   0 |     6 |
| Jobs                 |     19 |     10 |       2 |       1 |   0 |     8 |
| Models               |    107 |     80 |       5 |       5 |   1 |    14 |
| Mailers              |      4 |      4 |       1 |       0 |   0 |     0 |
| Channels             |      8 |      8 |       2 |       0 |   0 |     0 |
| Libraries            |     26 |     22 |       0 |       0 |   0 |     0 |
| Controller tests     |      8 |      7 |       1 |       1 |   1 |     5 |
| Model tests          |     28 |     12 |       4 |       0 |   0 |     0 |
| Mailer tests         |      0 |      0 |       0 |       0 |   0 |     0 |
| Channel tests        |     11 |      3 |       1 |       0 |   0 |     0 |
| Job tests            |      7 |      3 |       1 |       0 |   0 |     0 |
| Integration tests    |      0 |      0 |       0 |       0 |   0 |     0 |
| Controller specs     |     10 |      9 |       0 |       0 |   0 |     0 |
| Job specs            |     10 |      9 |       0 |       0 |   0 |     0 |
| Model specs          |    150 |    126 |       0 |       0 |   0 |     0 |
| Request specs        |     97 |     76 |       0 |       0 |   0 |     0 |
+----------------------+--------+--------+---------+---------+-----+-------+
| Total                |    504 |    385 |      20 |       9 |   0 |    40 |
+----------------------+--------+--------+---------+---------+-----+-------+
  Code LOC: 140     Test LOC: 245     Code to Test Ratio: 1:1.8
```
