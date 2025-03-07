require 'spec_helper'

RSpec.describe VehicleFactory do
  it "exists" do
    factory = VehicleFactory.new
    expect(factory).to be_an_instance_of(VehicleFactory)
  end

  it "creates a vehicle from a list of one vehicle" do
    factory = VehicleFactory.new
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    created_vehicles = factory.create_vehicles([{vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice}])
    
    expect(created_vehicles[0].vin).to eq(@cruz.vin)
    expect(created_vehicles[0].year).to eq(@cruz.year)
    expect(created_vehicles[0].make).to eq(@cruz.make)
    expect(created_vehicles[0].model).to eq(@cruz.model)
  end

  it "creates vehicles from a list of vehicles" do
    factory = VehicleFactory.new
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    created_vehicles = factory.create_vehicles([{vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice}, {vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev}])
    
    expect(created_vehicles[0].vin).to eq(@cruz.vin)
    expect(created_vehicles[0].year).to eq(@cruz.year)
    expect(created_vehicles[0].make).to eq(@cruz.make)
    expect(created_vehicles[0].model).to eq(@cruz.model)
    expect(created_vehicles[1].vin).to eq(@bolt.vin)
    expect(created_vehicles[1].year).to eq(@bolt.year)
    expect(created_vehicles[1].make).to eq(@bolt.make)
    expect(created_vehicles[1].model).to eq(@bolt.model)
  end

  it "creates vehicles from an external list of vehicles" do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    renamed_vehicles = factory.rename_vehicles(wa_ev_registrations)
    created_vehicles = factory.create_vehicles(renamed_vehicles)
    
    expect(created_vehicles[0]).to be_an_instance_of(Vehicle)
    expect(created_vehicles).to be_an(Array)
    expect(created_vehicles.count).to eq(1000) 
  end

  it "can rename vehicle variables" do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations

    expect(factory.rename_vehicles(wa_ev_registrations).first[:vin]).to be_a(String)
    expect(factory.rename_vehicles(wa_ev_registrations).first[:year]).to be_a(String)
    expect(factory.rename_vehicles(wa_ev_registrations).first[:engine]).to be_a(Symbol)
  end
end

# Iteration 4 (failed) attempt:
  # it "can determine the most common make/model in a list" do
  #   factory = VehicleFactory.new
  #   @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
  #   @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
  #   @cruz = Vehicle.new({vin: '333333333abcdefgh', year: 2013, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
  #   created_vehicles = factory.create_vehicles([{vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice}, {vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev}])
    
  #   short_list = factory.create_vehicles([{vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice}, {vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev}, {vin: '333333333abcdefgh', year: 2013, make: 'Chevrolet', model: 'Cruz', engine: :ice}])
  #   expect(common_models(short_list)).to eq ("cruz") 
  # end