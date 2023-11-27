class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at, :user_identity
end
