# lib/devise/models/remote_authenticatable.rb
module Devise
  module Models
    module RemoteAuthenticatable
      extend ActiveSupport::Concern
 
      #
      # Here you do the request to the external app using an 
      # ActiveResource model
      #.
      # If the authentication is successful, you should return
      # a resource instance.
      #
      # If the authentication fails, you should return false.
      #
      def remote_authentication(authentication_hash)
        begin
          # invoke /users/sign_in on other app
          # ensure you use SSL :-)
          response = MyRemoteService::User.get(:sign_in, {:email => authentication_hash[:email], :password => authentication_hash[:password]})
        rescue
          return false
        end

        return false if response.nil?
        # create our local (PORO) User model to hold the details
        user = User.new
        user.id = response['id']
        user.email = response['email']
        user
      end
 
      module ClassMethods
        ####################################
        # Overriden methods from Devise::Models::Authenticatable
        ####################################
 
        #
        # This method is called from:
        # Warden::SessionSerializer in devise
        #
        # It takes as many params as elements had the array
        # returned in serialize_into_session
        #
        # Recreates a resource from session data
        #
        def serialize_from_session(id,email)
          resource = self.new
          resource.id = 1
          resource.email = email
          resource
        end
 
        #
        # Here you have to return and array with the data of your resource
        # that you want to serialize into the session
        #
        # You might want to include some authentication data
        #
        def serialize_into_session(record)
          [record.id, record.email]
        end
 
      end
    end
  end
end