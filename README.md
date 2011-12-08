# OmniAuth Active Passport

This is the official OmniAuth strategy for authenticating to Active Passport. To
use it, you'll need to sign up for an OAuth2 Application ID and Secret
on the [Active Passport Applications Page](https://passport.active.com/passport/manage).


## Usage with Devise

Add the following code to devise.rb:

	config.omniauth :active_passport, 'ACTIVE_PASSPORT_KEY', 'ACTIVE_PASSPORT_SECRET', :strategy_class => OmniAuth::Strategies::ActivePassport


Create a controller under users/omniauth_callbacks_controller.rb and add the following:

	class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	  def passthru
	    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
	  end
	
	  def active_passport
	    # successful logic authentication goes here
		# token will be in request.env['omniauth.auth']
	  end
	end


Modify routes.rb to include the following:

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
	devise_scope :user do
	  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
	end
	

Devise will create the following url method for linking to the provider:
	
	user_omniauth_authorize_path(:active_passport)


## Testing

You will need to turn on "test mode" for OmniAuth:

	OmniAuth.config.test_mode = true
	

Once test mode has been enabled, mock_auth will allow you to set provider authentication hash to return during testing:

	OmniAuth.config.mock_auth[:active_passport] = {
		:provider => 'active_passport',
		:uid => '1234567890',
		:info => {
		 :email => 'test@example.com'
		}
	  })


The following two env variables are needed to prevent routing errors during OmniAuth controller tests:

	before do 
	  request.env["devise.mapping"] = Devise.mappings[:user] 
	  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:active_passport] 
	end