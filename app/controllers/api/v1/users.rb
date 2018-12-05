# rubocop:disable BlockLength
require "net/http"

module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc "Return all users"
        get "", root: :graduates do
          User.all
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: "graduate" do
          User.find(permitted_params[:id])
        end

        desc "Generate token for user"
        params do
          requires :username, type: String, desc: "Username or e-mail address of the user"
          requires :password, type: String, desc: "Password of the user"
          requires :grant_type, type: String,
                                desc: "Grant type of OAuth request",
                                values: %w(password client_credentials)
        end
        post "/token", root: "oauth" do
          user = User.find_for_database_authentication(login: params[:username])
          if user&.valid_for_authentication? { user.valid_password?(params[:password]) }
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
        end
      end
    end
  end
end

# rubocop:enable BlockLength
