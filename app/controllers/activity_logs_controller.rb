class ActivityLogsController < ApplicationController
  before_action :set_activity_log, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /activity_logs
  def index
    # Fetches only the activity logs of the current logged-in user
    @activity_logs = current_user.activity_logs

    render json: @activity_logs
  end

  # GET /activity_logs/1
  def show
    puts "Current user: #{current_user.inspect}"
    render json: @activity_log
  end

  # POST /activity_logs
def create
  # Get the count of activity logs before creating a new one
  previous_count = ActivityLog.count

  # Builds a new activity log linked to the current user
  @activity_log = current_user.activity_logs.build(activity_log_params)

  if @activity_log.save
    render json: @activity_log, status: :created, location: @activity_log
  else
    # Output errors from the last activity log
    puts ActivityLog.last.errors.full_messages if ActivityLog.count > previous_count

    render json: @activity_log.errors, status: :unprocessable_entity
  end
end

  # PATCH/PUT /activity_logs/1
  def update
    if @activity_log.update(activity_log_params)
      render json: @activity_log
    else
      render json: @activity_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /activity_logs/1
  def destroy
    @activity_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity_log
      puts "Current user: #{current_user.inspect}"
      @activity_log = current_user.activity_logs.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_log_params
      params.require(:activity_log).permit(:exercise, :duration, :date)
    end
end

