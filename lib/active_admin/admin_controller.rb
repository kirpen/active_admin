module ActiveAdmin
  class AdminController < ApplicationController
    before_filter :authenticate_active_admin_user
    
    class << self
      # Reference to the Resource object which initialized
      # this controller
      attr_accessor :active_admin_config

      def active_admin_config=(config)
        @active_admin_config = config
        defaults  :resource_class => config.resource,
                  :route_prefix => config.route_prefix,
                  :instance_name => config.underscored_resource_name
      end
    end
    
    protected
    
    # Calls the authentication method as defined in ActiveAdmin.authentication_method
    def authenticate_active_admin_user
      send(active_admin_application.authentication_method) if active_admin_application.authentication_method
    end

    def current_active_admin_user
      send(active_admin_application.current_user_method) if active_admin_application.current_user_method
    end
    helper_method :current_active_admin_user

    def current_active_admin_user?
      !current_active_admin_user.nil?
    end
    helper_method :current_active_admin_user?

    def active_admin_config
      self.class.active_admin_config
    end
    helper_method :active_admin_config

    def active_admin_application
      ActiveAdmin.application
    end
  end
end