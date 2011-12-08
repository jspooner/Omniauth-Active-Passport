require 'omniauth-oauth2'
require 'oauth2_patch/client'

module OmniAuth
  module Strategies
    class ActivePassport < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "active_passport"
      
      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => 'https://passport.active.com',
        :authorize_url => '/oauth2/authorize',
        :token_url => '/oauth2/token'
      }
      
      option :token_params, { :parse => :json }
      
      uid { access_token.params['activeEnterprisePersonId'] }
      
      info do
        {
          :email => access_token.params['userName'],
          :expires_at => access_token.params['expireDateTime']
        }
      end
      
      credentials do
        {
          :token => access_token.params['accessToken']
        }
      end
      
      extra do
        { 
          :access_token => access_token
        }
      end
    end
  end
end