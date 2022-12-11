# load_and_authorize_resource
class ApplicationController < ActionController::Base
  load_and_authorize_resource if: lambda { |controller| [:municipes,].include? controller.controller_name.to_sym }
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:landing_page]
  # rescue_from Exception, :with => :render_500
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/', :alert => exception.message
  end
  def render_500(exception)
    @exception = exception
    ApplicationMailer.with(exception: exception).erro_500_mail.deliver_now! if ::MAILER_PASSWORD.present?
    render :template => "errors/500", :status => 500, layout: false
  end



end
