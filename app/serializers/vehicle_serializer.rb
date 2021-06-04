class VehicleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :make, :model, :year
end
