require 'finicity/configurable'
require 'finicity/version'
require 'finicity/client'
require 'active_support/all'

module Finicity
  extend Finicity::Configurable

  class ApiServerError < StandardError; end
  class TokenRefreshError < StandardError; end
  class LoadHistoricTxnError < StandardError; end

  # Description: Expired Finicity app token
  # Required Action: Renew app token
  INVALID_APP_TOKEN_CODES = [10_022, 10_023].freeze

  # Description: Retry Error or Problem Connecting to the Institution
  # Required Action: Nothing. Just try again later.
  CONNECTION_PROBLEM_CODES = [102, 320, 580].freeze

  # Description: Invalid Credentials
  # Required Action: Prompt the customer for the correct credentials.
  INVALID_CREDENTIALS_CODES = [103].freeze

  # Description: User Action Required
  # Required Action: Prompt the user to login to their account directly at the institution's website
  # and follow the instructions there
  USER_ACTION_REQUIRED_CODES = [108, 109].freeze

  # Description: Missing or Incorrect MFA Answer
  # Required Action: Refresh Customer Account and follow the MFA sequence to prompt the user for the missing information
  INCORRECT_MFA_ANSWERS_CODES = [185, 187].freeze

  # Description: The account is currently being aggregated.
  # Required Action: Nothing. This is only an informational message. Try again later.
  ACCOUNT_BEING_AGG_CODES = [325, 5006].freeze

  # Description: Missing Parameter
  # Required Action: A required field was left blank, Submit the request again, with valid text
  MISSING_PARAMS_CODES = [10_005].freeze
end
