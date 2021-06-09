require 'rails_helper'


describe 'Profile Poro' do
  describe 'we can pass information to create profile objects' do
    it 'shows profile information on your own page' do
      dominic  = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      jake     = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      cydnee   = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

      ride1    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: jake.id )
      ride2    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: cydnee.id )
      ride3    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: dominic.id )

      friends1 = Friend.create!(requestor_id: jake.id, receiver_id: dominic.id, status: 1)
      friends2 = Friend.create!(requestor_id: jake.id, receiver_id: cydnee.id, status: 1)
      friends3 = Friend.create!(requestor_id: dominic.id, receiver_id: cydnee.id, status: 1)


      pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
      geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
      geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')

      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride1.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride1.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride1.id)
      rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
      rideday7 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
      profile = Profile.new(dominic, dominic.id)

      expect(profile.id).to eq(dominic.id)
      expect(profile.fullname).to eq(dominic.fullname)
      expect(profile.bio).to eq(dominic.bio)
      expect(profile.email).to eq(dominic.email)
      expect(profile.user_rides.first).to eq(ride3)
      expect(profile.friendship_status).to eq(["self", dominic.id])
      expect(profile.vehicle.first).to eq(pinto)
      expect(profile.ride_days).to eq(["monday", "wednesday", "thursday"])
    end
    it 'shows profile information on someone elses page and friendship is approved' do
      dominic  = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      jake     = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      cydnee   = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

      ride1    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: jake.id )
      ride2    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: cydnee.id )
      ride3    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: dominic.id )

      friends1 = Friend.create!(requestor_id: jake.id, receiver_id: dominic.id, status: 1)
      friends2 = Friend.create!(requestor_id: jake.id, receiver_id: cydnee.id, status: 1)
      friends3 = Friend.create!(requestor_id: dominic.id, receiver_id: cydnee.id)


      pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
      geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
      geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')

      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride1.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride1.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride1.id)
      rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
      rideday7 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
      profile = Profile.new(jake, dominic.id)

      expect(profile.bio).to eq(jake.bio)
      expect(profile.email).to eq(jake.email)
      expect(profile.friendship_status).to eq(["approved", jake.email])
    end
    it 'shows profile information on someone elses page and friendship is approve/deny' do
      dominic  = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      jake     = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      cydnee   = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

      ride1    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: jake.id )
      ride2    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: cydnee.id )
      ride3    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: dominic.id )

      friends1 = Friend.create!(requestor_id: jake.id, receiver_id: dominic.id, status: 1)
      friends2 = Friend.create!(requestor_id: jake.id, receiver_id: cydnee.id, status: 1)
      friends3 = Friend.create!(requestor_id: cydnee.id, receiver_id: dominic.id)


      pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
      geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
      geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')

      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride1.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride1.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride1.id)
      rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
      rideday7 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
      profile = Profile.new(dominic, cydnee.id)

      expect(profile.bio).to eq(dominic.bio)
      expect(profile.email).to eq(dominic.email)
      expect(profile.friendship_status).to eq(["pending", friends3.id])
    end
    it 'shows profile information on someone elses page and friendship is approve/deny' do
      dominic  = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      jake     = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      cydnee   = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

      ride1    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: jake.id )
      ride2    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: cydnee.id )
      ride3    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: dominic.id )

      friends1 = Friend.create!(requestor_id: jake.id, receiver_id: dominic.id, status: 1)
      friends2 = Friend.create!(requestor_id: jake.id, receiver_id: cydnee.id, status: 1)
      friends3 = Friend.create!(requestor_id: dominic.id, receiver_id: cydnee.id)


      pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
      geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
      geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')

      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride1.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride1.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride1.id)
      rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
      rideday7 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
      profile = Profile.new(dominic, cydnee.id)

      expect(profile.bio).to eq(dominic.bio)
      expect(profile.email).to eq(dominic.email)
      expect(profile.friendship_status).to eq(["approve/deny", friends3.id])
    end
    it 'shows profile information on someone elses page and friendship is approve/deny' do
      dominic  = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
      jake     = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
      cydnee   = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

      ride1    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: jake.id )
      ride2    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: cydnee.id )
      ride3    = Ride.create!(origin: "3956 Alcott St, Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: dominic.id )

      friends1 = Friend.create!(requestor_id: jake.id, receiver_id: dominic.id, status: 1)
      friends2 = Friend.create!(requestor_id: jake.id, receiver_id: cydnee.id, status: 1)

      pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
      geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
      geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')

      rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride1.id)
      rideday2 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride1.id)
      rideday3 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride1.id)
      rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
      rideday5 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
      rideday6 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
      rideday7 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
      rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
      rideday9 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
      profile = Profile.new(dominic, cydnee.id)

      expect(profile.bio).to eq(dominic.bio)
      expect(profile.email).to eq(dominic.email)
      expect(profile.friendship_status).to eq(["add", dominic.id])
    end
  end
end
