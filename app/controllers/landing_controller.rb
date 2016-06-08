class LandingController < ApplicationController

	# Helper Methods for Devise Start
	  helper_method :resource_name, :resource, :devise_mapping

	  def resource_name
	    :user
	  end

	  def resource
	    @resource ||= User.new
	  end

	  def devise_mapping
	    @devise_mapping ||= Devise.mappings[:user]
	  end
	  # Helper Methods for Devise End


		def index
			redirect_to locations_path if current_user
		end
end
