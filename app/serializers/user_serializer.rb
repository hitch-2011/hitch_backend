class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email,
             :about_me
end
