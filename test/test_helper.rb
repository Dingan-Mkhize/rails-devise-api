ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'jwt' # Add JWT library

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Helper method to generate JWT token for test users
  def generate_jwt_for(user)
    payload = {
      user_id: user.id,
      exp: (Time.now + 30.minutes).to_i
    }

    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end


