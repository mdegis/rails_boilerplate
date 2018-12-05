# rubocop:disable BlockLength

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  resource_owner_from_credentials do
    user = User.find_for_database_authentication(login: params[:username])
    if user&.valid_for_authentication? { user.valid_password?(params[:password]) }
      user
    end
  end

  # If you didn't skip applications controller from Doorkeeper routes in your application routes.rb
  # file then you need to declare this block in order to restrict access to the web interface for
  # adding oauth authorized applications. In other case it will return 403 Forbidden response
  # every time somebody will try to access the admin web interface.
  #
  # admin_authenticator do
  #   # Put your admin authentication logic here.
  #   # Example implementation:
  #
  #   if current_user
  #     head :forbidden unless current_user.admin?
  #   else
  #     redirect_to sign_in_url
  #   end
  # end

  # Authorization Code expiration time (default 10 minutes).
  #
  # authorization_code_expires_in 10.minutes

  # Access token expiration time (default 2 hours).
  # If you want to disable expiration, set this to nil.
  #
  # access_token_expires_in 2.hours

  # access_token_generator '::Doorkeeper::JWT'

  use_refresh_token

  native_redirect_uri "urn:ietf:wg:oauth:2.0:oob"

  # Specify what grant flows are enabled in array of Strings. The valid
  # strings and the flows they enable are:
  #
  # "authorization_code" => Authorization Code Grant Flow
  # "implicit"           => Implicit Grant Flow
  # "password"           => Resource Owner Password Credentials Grant Flow
  # "client_credentials" => Client Credentials Grant Flow
  #
  grant_flows %w(password client_credentials)

  # Under some circumstances you might want to have applications auto-approved,
  # so that the user skips the authorization step.
  # For example if dealing with a trusted application.
  #
  # skip_authorization do |resource_owner, client|
  #   client.superapp? or resource_owner.admin?
  # end
end

# rubocop:enable BlockLength
