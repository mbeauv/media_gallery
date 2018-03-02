module MediaGallery
  class ApplicationController < ActionController::API

    include CanCan::ControllerAdditions

    rescue_from CanCan::AccessDenied do |exception|
      render json: { message: "Access Denied" }, status: 403
    end

    rescue_from ActiveRecord::RecordInvalid do |exception|
      render json: { message: exception.to_s }, status: 500
    end

    def current_user
      raise 'You need to override the current_user.'
    end

    def create_ability(user)
      raise 'You need to override the create_ability method.'
    end

    def current_ability
      @current_ability ||= create_ability(current_user)
    end

  end

end
