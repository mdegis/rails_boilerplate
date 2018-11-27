class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :last_seen,
             :last_sign_in_ip, :sign_in_count,
             :created_at, :updated_at
end
