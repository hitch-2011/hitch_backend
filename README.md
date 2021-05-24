# Hitch Backend

This is the backend engine fueling Hitch, a web application that connects users to similar routes and can help get vehicles off the road. The application is built with service oriented architecture and this app does most of the heavy lifting (see [Project Architecture](#project-architecture)). The backend communicates with the frontend using 5 API JSON endpoints. It stores all our information in our databases.

The API endpoints allow other apps to store Users, Ridedays, Rides, Vehciles, and Friends.  There is functionality on the backend to find matching routes requests all the zipcodes near your specific destination/origin and grabs users with matching routes in those specific areas. 

### Related Repos
To explore the full web application, please visit the built out front end application that hooks into this engine and its endpoints.
 - [Hitch - frontend](https://github.com/hitch-2011/hitch-fe).

To get zipcodes within a specified radius, please visit the radius microservice.
  - [Radius Microservice](https://github.com/hitch-2011/hitch_microservice_radius) 
 
To check driveable routes we used mapquest api. 
  - [Hitch Mapquest](https://github.com/hitch-2011/hitch_microservice_mapquest) 

### Created by:
- [Jake Volpe](https://github.com/javolpe) | [LinkedIn](https://www.linkedin.com/in/jake-volpe-bb602b126/)
- [Cydnee Owensl](https://github.com/cowens87) | [LinkedIn](https://www.linkedin.com/in/cydnee-owens-683a3450/)
- [Dominic Padula](https://github.com/domo2192) | [LinkedIn](https://www.linkedin.com/in/dominic-padula-5bb5b2179/)
- [Steven Mancine](https://github.com/itsnameissteven) | [LinkedIn](https://www.linkedin.com/in/steven-mancine-13509521/)
- [Paige Vannelli](https://github.com/PaigeVannelli) | [LinkedIn](https://www.linkedin.com/in/paigevannelli/)
- [Alex Thompson](https://github.com/alexthompson207) | [LinkedIn](https://www.linkedin.com/in/alex-thompson-he-him/)

#### Built With
* [Ruby on Rails](https://rubyonrails.org)
* [HTML](https://html.com)

This project was tested with:
* RSpec version 3.10
* [Postman](https://www.postman.com/) Explore and test the API endpoints using Postman, and use Postman’s CLI to execute collections directly from the command-line.

## Contents
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installing](#installing)
- [Endpoints](#endpoints)  
- [Project Architecture](#project-architecture)  
- [Database Schema](#database-schema)  
- [Application Features](#application-features)
  - [Feature 1](#feature-1)
- [Testing](#testing)
- [How to Contribute](#how-to-contribute)
- [Roadmap](#roadmap)
- [Contributors](#contributors)
- [Acknowledgments](#acknowledgments)

### Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system. Endpoints can be added. If you plan to use this engine with the frontend web application, if the endpoints are changed subsequent updates will be necessary on the Frontend repository code.

#### Prerequisites

* __Ruby__

  - The project is built with rubyonrails using __ruby version 2.5.3p105__, you must install ruby on your local machine first. Please visit the [ruby](https://www.ruby-lang.org/en/documentation/installation/) home page to get set up. _Please ensure you install the version of ruby noted above._

* __Rails__
  ```sh
  gem install rails --version 5.2.5
  ```

* __Postgres database__
  - Visit the [postgresapp](https://postgresapp.com/downloads.html) homepage and follow their instructions to download the latest version of Postgres app.

#### Frontend dependancies

#### Installing

1. Clone the repo
  ```
  $ git clone https://github.com/Yardsourcing/yardsourcing-frontend
  ```

2. Bundle Install
  ```
  $ bundle install
  ```

3. Create, migrate and seed rails database
  ```
  $ rails db:{create,migrate,seed}
  ```

4. Set up Environment Variables:
  - run `bundle exec figaro install`
  - add the below variable to the `config/application.yml` if you wish to use the existing email microservice. Otherwise you replace it the value with service if desired.
  ```
    EMAIL_MICROSERVICE: 'https://peaceful-bastion-57477.herokuapp.com'
  ```

  If you do not wish to use the sample data provided to seed your database, replace the commands in `db/seeds.rb`.

### Endpoints
| HTTP verbs | Paths  | Used for |
| ---------- | ------ | --------:|
| Post | /api/v1/users | Create users and associated vehicle with user. |
| GET | /api/v1/users/:id  | Get the profile information of a specific user. |
| POST | /api/v1/users/:id/rides | Create an associated route with a user. |
| GET | /api/v1/users/:id/rides  | Get all the matched routes with a specific users ride.|


#### Postman
- To run postman endpoints, start the Yardsourcing engine in locally
    `rails s -p 3001`
- Utilize this [link](https://www.getpostman.com/collections/de993f8fcc4c974d68a2) to download the postman suite


<!-- ### Project Architecture
<p style="text-align:center;"><img src="ys_design.png" width="600"></p> -->

### Database Schema
<p style="text-align:center;"><img src="[Hitch](https://user-images.githubusercontent.com/70593322/119404999-d4bd5f80-bc9d-11eb-9ef6-c5bea2de3bf9.png)
" height="350"></p>

### Testing
##### Running Tests
- To run the full test suite run the below in your terminal:
```
$ bundle exec rspec
```
- To run an individual test file run the below in tour terminal:
```
$ bundle exec rspec <file path>
```
for example: `bundle exec rspec spec/features/host/dashboard/index_spec.rb`

### How to Contribute

In the spirit of collaboration, things done together are better than done on our own. If you have any amazing ideas or contributions on how we can improve this API they are **greatly appreciated**. To contribute:

  1. Fork the Project
  2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
  3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
  4. Push to the Branch (`git push origin feature/AmazingFeature`)
  5. Open a Pull Request

### Roadmap

See the [open issues](https://github.com/hitch-2011/hitch_backend/issues) for a list of proposed features (and known issues). Please open an issue ticket if you see an existing error or bug.

