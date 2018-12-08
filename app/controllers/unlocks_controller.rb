class UnlocksController < Devise::UnlocksController
  def show
    self.resource = resource_class.unlock_access_by_token(params[:unlock_token])
    yield resource if block_given?

    if !resource.errors.empty?
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end
end
