class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles, :collected_fees

  def initialize(facility_info)
    @name = facility_info[:name]
    @address = facility_info[:address]
    @phone = facility_info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if services.include?('Vehicle Registration')
      @registered_vehicles << vehicle
      vehicle.registration_date = Date.today
      if vehicle.antique?
        @collected_fees += 25
        vehicle.plate_type = :antique
      elsif vehicle.electric_vehicle?
        @collected_fees += 200
        vehicle.plate_type = :ev
      else
        @collected_fees += 100
        vehicle.plate_type = :regular
      end
      @registered_vehicles
    else
      nil
    end
  end

  def administer_written_test(registrant)
    if services.include?('Written Test')
      if registrant.permit? && registrant.age >= 16
        registrant.license_data[:written] = true
      else 
        false
      end
    else
      false
    end
  end



  def administer_road_test(registrant)
    if services.include?('Road Test') && registrant.license_data[:written] == true
      registrant.license_data[:license] = true
    else
      false
    end
  end




  def renew_drivers_license(registrant)
    if services.include?('Renew License') && registrant.license_data[:license] == true
      registrant.license_data[:renewed] = true
    else
      false
    end
  end


# Renew a driver’s license:

#   A license can only be renewed if the registrant has already passed the road test and earned a license


# NOTE: A facility must offer a service in order to perform it. Just because the DMV allows facilities to perform certain services, does not mean that every facility provides every service.



end #final
