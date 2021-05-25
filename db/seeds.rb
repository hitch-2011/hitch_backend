dominic  = User.create!(fullname: "Dominic", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
jake     = User.create!(fullname: "Jake", email: "jake@gmail.com", password: "password", bio: "I like driving.")
cydnee   = User.create!(fullname: "Cydnee", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")
steven   = User.create!(fullname: "Steven", email: "steven@gmail.com", password: "password", bio: "I like driving.")
alex   = User.create!(fullname: "Steven", email: "alex@gmail.com", password: "password", bio: "I like driving.")

ride1    = Ride.create!(origin: "1719 S Uinta Way, Denver, CO 80231", destination: "320 S Jasmine St, Denver, CO 80224, USA", departure_time: "9:00am", user_id: jake.id )
ride2    = Ride.create!(origin: "9182 E Harvard Ave, Denver, CO 80231, USA", destination: "4381 E Montana Pl, Denver, CO 80222, USA", departure_time: "9:00am", user_id: cydnee.id )
ride3    = Ride.create!(origin: "8659 E Wesley Dr, Denver, CO 80231, USA", destination: "1832 S Ivanhoe St, Denver, CO 80224, USA", departure_time: "9:00am", user_id: dominic.id )
ride4    = Ride.create!(origin: "9142 E Missouri Ave, Denver, CO 80247, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: steven.id )
ride5    = Ride.create!(origin: "4381 E Montana Pl, Denver, CO 80222, USA", destination: "9142 E Missouri Ave, Denver, CO 80247, USA", departure_time: "9:00am", user_id: steven.id )

friends1 = Friend.create!(user_id: jake.id, friend_id: dominic.id)
friends2 = Friend.create!(user_id: jake.id, friend_id: cydnee.id)
friends11 = Friend.create!(user_id: jake.id, friend_id: steven.id)
friends12 = Friend.create!(user_id: jake.id, friend_id: alex.id)
friends3 = Friend.create!(user_id: dominic.id, friend_id: cydnee.id)
friends4 = Friend.create!(user_id: dominic.id, friend_id: jake.id)
friends7 = Friend.create!(user_id: steven.id, friend_id: dominic.id)
friends8 = Friend.create!(user_id: alex.id, friend_id: dominic.id)
friends5 = Friend.create!(user_id: cydnee.id, friend_id: jake.id)
friends6 = Friend.create!(user_id: cydnee.id, friend_id: dominic.id)
friends9 = Friend.create!(user_id: cydnee.id, friend_id: alex.id)
friends10 = Friend.create!(user_id: cydnee.id, friend_id: steven.id)

pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')
new_car = Vehicle.create!(user_id: steven.id, make: 'make', model: 'model', year: '1988')
new_car = Vehicle.create!(user_id: alex.id, make: 'make', model: 'model', year: '1988')

rideday = Rideday.create!(day_of_week: 'Monday', ride_id: ride1.id)
rideday2 = Rideday.create!(day_of_week: 'Monday', ride_id: ride2.id)
rideday3 = Rideday.create!(day_of_week: 'Monday', ride_id: ride3.id)
rideday4 = Rideday.create!(day_of_week: 'Monday', ride_id: ride4.id)
rideday5 = Rideday.create!(day_of_week: 'Monday', ride_id: ride5.id)
rideday6 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride1.id)
rideday7 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride2.id)
rideday8 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride3.id)
rideday9 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride4.id)
rideday10 = Rideday.create!(day_of_week: 'Wednesday', ride_id: ride5.id)
rideday11 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride1.id)
rideday12 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride2.id)
rideday13 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride3.id)
rideday14 = Rideday.create!(day_of_week: 'Thursday', ride_id: ride4.id)
