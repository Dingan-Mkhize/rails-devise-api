require 'test_helper'
require 'jwt' # Import the JWT library
require 'securerandom'

class ActivityLogsControllerTest < ActionDispatch::IntegrationTest

  def generate_jwt_for(user)
  # Fetch the secret key from the TEST_JWT_SECRET environment variable
  secret_key = ENV['TEST_JWT_SECRET']
  raise "JWT secret key is not set in the environment!" unless secret_key

  payload = { user_id: user.id }
  JWT.encode(payload, secret_key, 'HS256')
end

  setup do
    @user = users(:user_one)
    @other_user = users(:user_two)
    @activity_log = activity_logs(:log_one)
    @token = generate_jwt_for(@user)
    @other_user_token = generate_jwt_for(@other_user)
  end

  test "should get index with valid JWT" do
    puts "Token being used: #{@token}"
    get activity_logs_url, headers: { Authorization: "Bearer #{@token}" }
    assert_response :success
  end

  test "should create activity log with valid JWT" do
    puts "Token being used: #{@token}"
    assert_difference('ActivityLog.count') do
      post activity_logs_url, params: { activity_log: { excercise: 'Cycling', duration: 60, date: '2023-01-03' } }, headers: { Authorization: "Bearer #{@token}" }
    end
    assert_response :created
  end

  test "should update activity log with valid JWT" do
    patch activity_log_url(@activity_log), params: { activity_log: { duration: 45 } }, headers: { Authorization: "Bearer #{@token}" }
    assert_response :success
  end

  test "should destroy activity log with valid JWT" do
    puts "Token being used: #{@token}"
    assert_difference('ActivityLog.count', -1) do
      delete activity_log_url(@activity_log), headers: { Authorization: "Bearer #{@token}" }
    end
    assert_response :no_content
  end

  test "should not access logs of other users with valid JWT" do
    puts "Token being used: #{@token}"
    get activity_log_url(@activity_log), headers: { Authorization: "Bearer #{@other_user_token}" }
    assert_response :forbidden # Or :not_found, depending on your authorization setup
  end

  test "unauthenticated access" do
    puts "Token being used: #{@token}"
    get activity_logs_url # No headers for unauthenticated request
    assert_response :unauthorized
  end
end



