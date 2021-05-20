class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname,
             :email,
             :bio
end
