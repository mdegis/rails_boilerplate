require "doorkeeper/grape/helpers"

module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      helpers Doorkeeper::Grape::Helpers

      before do
        doorkeeper_authorize!
      end

      resource :users do
        desc "Return all users"
        paginate per_page: 10, max_per_page: 200
        get "", root: :users do
          paginate User.all
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: "user" do
          User.find(permitted_params[:id])
        end
      end
    end
  end
end
