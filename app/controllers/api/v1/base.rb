require "grape-swagger"

module API
  module V1
    class Base < Grape::API
      mount API::V1::Users
      # mount API::V1::AnotherResources

      add_swagger_documentation(
        api_version: "v1",
        hide_documentation_path: true,
        mount_path: "/api/v1/swagger_doc",
        hide_format: true,
        info: {
          title: "Rails Boilerplate API",
          description: "Rails Boilerplate API documentation description.",
          contact_name: "Rails Boilerplate",
          contact_email: "john_smith@exaple.com",
          contact_url: "https://example.com",
          license: "Copyright",
          license_url: "https://www.patentsoffice.ie/en/Copyright/",
        },
      )
    end
  end
end
