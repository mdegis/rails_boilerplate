GrapeSwaggerRails.options.url = "/api/v1/swagger_doc"
GrapeSwaggerRails.options.app_url = if Rails.env.development?
                                      "http://localhost:3000"
                                    else
                                      "http://localhost:3001"
                                    end
GrapeSwaggerRails.options.app_name = "RailsBoilerplate"
GrapeSwaggerRails.options.hide_url_input = true
GrapeSwaggerRails.options.api_auth = "bearer"
GrapeSwaggerRails.options.api_key_name = "Authorization"
GrapeSwaggerRails.options.api_key_type = "header"

GrapeSwaggerRails.options.before_action do |_request|
  redirect_to "/users/sign_in" if current_user.blank?
  # GrapeSwaggerRails.options.api_key_default_value = current_user.token if current_user
end
