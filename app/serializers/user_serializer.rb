class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :fullname,
             :email,
             :about_me
end
