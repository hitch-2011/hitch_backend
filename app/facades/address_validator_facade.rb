class AddressValidatorFacade
  class << self
    def validate_address(origin, destination)
      AddressValidatorService.validate_address("#{origin}-#{destination}".parameterize)
    end
  end
end