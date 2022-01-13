class UnhandledController < ActionController::Base
  protect_from_forgery

  def index
    render json: {}
  end

  def error
    generate_unhandled_error
  end

  def error_in_active_record_callback
    User.class_eval do
      after_commit { raise 'Oh no!' }
    end

    user = User.new({
      email: "uuu3@example.com",
      name: "User U. User III",
      first_name: "User",
      last_name: "User"
    })

    user.save

    render json: {}
  end
end
