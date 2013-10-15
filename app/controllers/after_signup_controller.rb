class AfterSignupController < ApplicationController
  include Wicked::Wizard

  before_filter :authenticate_user!

  steps :basic_settings, :link_github, :link_google, :complete

  def show
    @user = current_user 
    @current_step = current_step_index + 1
    @total_steps = steps.count
    render_wizard
  end

  def update
    @user = current_user

    case step
    when :basic_settings
      @user.update_attributes(user_params)
    end

    render_wizard @user
  end

  protected
    def user_params
      params.require(:user).permit(:skip_weekends, :time_zone)
    end
end