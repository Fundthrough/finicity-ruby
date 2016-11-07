# Finicity::Ruby
[![Build Status](https://travis-ci.org/Fundthrough/finicity-ruby.svg?branch=master)](https://travis-ci.org/Fundthrough/finicity-ruby)
[![Code Climate](https://codeclimate.com/github/Fundthrough/finicity-ruby/badges/gpa.svg)](https://codeclimate.com/github/Fundthrough/finicity-ruby)
[![codecov](https://codecov.io/gh/Fundthrough/finicity-ruby/branch/master/graph/badge.svg)](https://codecov.io/gh/Fundthrough/finicity-ruby)
[![License](http://img.shields.io/:license-MIT-blue.svg?style=flat)](LICENSE)


Welcome to `finicity-ruby` gem. This gem is built to communicate easily with Finicity's Aggregation API. It only uses the `JSON` representation of the API. Pull requests are welcome to help improving the gem.

- [Installation](#Installation)
- Setup(#Setup)
- Usage(#Usage)
- Contributing(#Contributing)
- License(#License)

## Installation

The gem is available through `Rubygems` and can be installed via:

    $ gem install finicity-ruby

or add it to your Gemfile like this:

```ruby
gem "finicity-ruby"
```

## Setup
Then, in your `config/initializers/` add `finicity.rb` file with corresponding values. Right now we are using redis to store the temp app token which used with each request. In the future, we are going to support multiple options to store token like memory, file & redis. Meanwhile just set the `redis_url` config into your redis host url.

    Finicity.configure do |config|
      config.redis_url      = "redis://127.0.0.1:6379"
      config.app_key        = "xxxxxxxxxxxxxxxx"
      config.partner_id     = "xxxxxxxxxxxxxxxx"
      config.partner_secret = "xxxxxxxxxxxxxxxx"
      config.app_type       = "testing" # or "active" for production apps.
      config.verbose        = false
      config.max_retries    = 1 # How many times do you want to retry the request in case timeout failures.
    end

## Usage
### 1. Institutions
#### List

To get all institutions

    response = Finicity::Client.institution.list
    response.status_code # 200
    response.success? # true
    response.body.institutions # returns all institutions [{name: "Royal Bank of Canada", id: "1411", ...]

To search for specific institution

    Finicity::Client.institution.list(search: "Royal Bank of Canada")

#### Get specific Institution (with login Credentials)
Using the `id` you just got from the list above, you can find any specific institution

    response = Finicity::Client.institution.get("107132")
    response.body.institution.login_credentials # [{id: 1231, name: "username", description: "Please enter your username", ...]

### 2. Customers
#### Add new customer
Finicity requires `username` to add a new customer. The response will contain the customer ID to be used for subsequent calls.

    response = Finicity::Client.customer.add("YetAnotherBatman")
    customer_id = response.body.customer.id

#### List all customers
To list all created customers from Finicity.

    Finicity::Client.customer.list

#### Delete customer
Using the `customer_id` you just got after you add the customer.

    Finicity::Client.scope(customer_id).delete
    
### 3. Accounts
#### Discover and add all accounts
To discover & add the accounts into your customer, you've to authenticate it using the `institution#login_credentials`.

    institution_id = 101732
    credentials = [{id: 101732001, name: "Banking Userid", value: "Azzurrio"}, { id: "101732002", name: "Banking Password", value: "LetMePass"]
    Finicity::Client.scope(customer_id).account.add_all(institution_id, credentials)
    
#### Discover and add all accounts (with MFA)
In case you get a MFA required. You can submit the answer into `add_all_mfa`. The `mfa_session` will be provided in `add_all` response headers.

    response = Finicity::Client.scope(customer_id).account.add_all(institution_id, credentials)
    response.status_code # 203
    mfa_session = response.headers["MFA-session"] # e86jnv923nsas4
    response.body.questions # [{ text: "What's your super hero?" }]
    answers = [{ text: "What's your super hero?", answer: "Batman" }]
    Finicity::Client.scope(customer_id).account.add_all_mfa(institution_id, mfa_sessiom, answers)
    
#### List accounts
 
    Finicity::Client.scope(customer_id).account.list
    
#### Get specific account
 
    Finicity::Client.scope(customer_id).account.get("236534") # using account id

#### Delete specific account
 
    Finicity::Client.scope(customer_id).account.delete(account_id)
 
#### Refresh accounts
After adding the accounts you have to refresh them so you can have access into their transactions.

    Finicity::Client.scope(customer_id).account.refresh(institution_login_id)
 
#### Refresh accounts (with MFA)
In case you get MFA, just like `as add_all_mfa`

    Finicity::Client.scope(customer_id).account.refresh(institution_login_id, mfa_session, answers)
 
#### Activate accounts
Sometimes you get accounts with type `unknown`, so you need to activate those accounts with the correct types.
    
    accounts = [{id: 12412, type: "savings"}, {id: 15434, type: "creditCard"}]
    Finicity::Client.scope(customer_id).account.activate(institution_id, accounts)
    
#### Update account credentials
In case account credentials have been changed, you can you get credentials and update them after populating the values correct credentials.
    
    Finicity::Client.scope(customer_id).account.credentials(account_id) # To be used for updating credentials
    Finicity::Client.scope(customer_id).account.update_credentials(account_id, credentials)

### 4. Transactions
#### List all transactions
This one will get all transactions for the given customer. You have to specify the date range using `from:` and `to:` named parameters.

    Finicity::Client.scope(customer_id).transaction.list(from: 6.months.ago, to: Date.today)

#### List all transactions for specific account
In case you only need transactions for specific account. You have to provide the `account_id` as extra parameter.

    Finicity::Client.scope(customer_id).transaction.list_for_account(account_id, from: 6.months.ago, to: Date.today)
    
#### Load historic transactions
This's a feature in Finicity API which gives you the ability to access +6 months transactions. This could be only used per account and it's an interactive request, which means MFA challenge could be appeared.

    Finicity::Client.scope(customer_id).transaction.load_historic(account_id)
    Finicity::Client.scope(customer_id).transaction.load_historic_mfa(account_id, mfa_session, answers)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Fundthrough/finicity-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

