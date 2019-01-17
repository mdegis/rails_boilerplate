# rubocop:disable BlockLength

module API
  module V1
    class Oauth < Grape::API
      include API::V1::Defaults

      resource :oauth do
        desc "Generate token for user"
        params do
          optional :username, type: String, desc: "Username or e-mail address of the user" +
            "Required if the `grant_type` is `password`."
          optional :password, type: String, desc: "Password of the user" +
            "Required if the `grant_type` is `password`."
          optional :refresh_token, type: String, desc: "Refresh token of the user." +
            "Required if the `grant_type` is `refresh token`."
          requires :grant_type, type: String,
                                desc: "Grant type of OAuth request",
                                values: %w(password refresh_token client_credentials)
        end
        post "/token", root: "oauth" do
          case permitted_params[:grant_type]
          when "password"
            user = User.find_for_database_authentication(login: permitted_params[:username])
            if user&.valid_for_authentication? { user.valid_password?(permitted_params[:password]) }
              token = user.access_tokens.create!(use_refresh_token: true,
                                                 expires_in: Doorkeeper.configuration.access_token_expires_in)
              Doorkeeper::OAuth::TokenResponse.new(token).body
            elsif user&.access_locked?
              error!({ "error": "locked_account",
                       "error_description": "The account you want to sign in with is locked due to too many wrong " +
                  "password attempts. Please check your e-mail to unlock it immediately or wait 2 hours" }, 401)

            else
              error!(Doorkeeper::OAuth::ErrorResponse.new(name: "invalid_grant").body, 401)
            end
          when "refresh_token"
            token = Doorkeeper::AccessToken.by_refresh_token(permitted_params[:refresh_token])
            if token&.revoke
              new_token = Doorkeeper::AccessToken.create!(use_refresh_token: true,
                                                          expires_in: Doorkeeper.configuration.access_token_expires_in,
                                                          resource_owner_id: token.resource_owner_id,
                                                          previous_refresh_token: permitted_params[:refresh_token])
              Doorkeeper::OAuth::TokenResponse.new(new_token).body
            else
              error!(Doorkeeper::OAuth::ErrorResponse.new(name: "invalid_grant").body, 401)
            end
          else
            error!(Doorkeeper::OAuth::ErrorResponse.new(name: "invalid_grant").body, 401)
          end
        end

        desc "Revoke an access token"
        params do
          requires :token, type: String, desc: "The token that will be revoked"
        end
        post "/revoke", root: "oauth" do
          Doorkeeper::AccessToken.find_by!(token: permitted_params[:token], revoked_at: nil)&.revoke
        end
      end
    end
  end
end

# rubocop:enable BlockLength
