class RemoteAuthStrategy < Warden::Strategies::Base
    def valid?
        Rails.logger.info '[INFO] remote strategy valid?'
        params['user'] && (params['user'].fetch('email') || params['user'].fetch('password'))
    end 
    
    def authenticate!
        Rails.logger.info '[INFO] remote strategy authenticate'
        user = params[:user]
        
        u = User.new 
        u = u.remote_authentication( :email => user[:email], :password => user[:password])
        
        u.nil? or u.eql? false ? fail!('unauthorized') : success!(u)
        
    end 
end 
