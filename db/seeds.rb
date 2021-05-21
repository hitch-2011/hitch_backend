dominic  = User.create!(fullname: "fullname", email: "dominic@gmail.com", password: "password", bio: "I like driving.")
jake     = User.create!(fullname: "fullname", email: "jake@gmail.com", password: "password", bio: "I like driving.")
cydnee   = User.create!(fullname: "fullname", email: "cydnee@gmail.com", password: "password", bio: "I like driving.")

ride1    = Ride.create!(origin: "3956 Alcott St Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: jake.id )
ride2    = Ride.create!(origin: "3956 Alcott St Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: cydnee.id )
ride3    = Ride.create!(origin: "3956 Alcott St Denver, CO 80211, USA", destination: "1125 S Kalispell St, Aurora, CO 80017, USA", departure_time: "9:00am", user_id: dominic.id )

friends1 = Friend.create!(user_id: jake.id, friend_id: dominic.id)
friends2 = Friend.create!(user_id: jake.id, friend_id: cydnee.id)
friends3 = Friend.create!(user_id: dominic.id, friend_id: cydnee.id)
friends4 = Friend.create!(user_id: dominic.id, friend_id: jake.id)
friends5 = Friend.create!(user_id: cydnee.id, friend_id: jake.id)
friends6 = Friend.create!(user_id: cydnee.id, friend_id: dominic.id)

pinto    = Vehicle.create!(user_id: dominic.id, make: 'make', model: 'model', year: '1991')
geometro = Vehicle.create!(user_id: cydnee.id, make: 'make', model: 'model', year: '1992')
geostorm = Vehicle.create!(user_id: jake.id, make: 'make', model: 'model', year: '1988')

mtw      = Rideday.create!(ride_id: ride1.id, day_of_week: ['Monday', 'Tuesday', 'Wednesday'])
twr      = Rideday.create!(ride_id: ride2.id, day_of_week: ['Tuesday', 'Wednesday', 'Thursday'])
mfs      = Rideday.create!(ride_id: ride3.id, day_of_week: ['Monday', 'Friday', 'Saturday'])
