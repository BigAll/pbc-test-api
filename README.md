# Test api application

### Pre-requsits
* Install ruby 2.1.10

### Instalation
* ```bundle install```
* ```rake db:migrate```
* ```rake db:seed```

### Running tests
* ```rspec spec/```

### Running Requests
* Request 1
  * ```curl -H "Content-Type: application/json" http://admin:secret-password@localhost:3000/api/v1/private/locations/Russia```
* Request 2
  * ```curl -H "Content-Type: application/json" http://admin:secret-password@localhost:3000/api/v1/private/target_groups/Russia```
* Request 3
  * ```curl -H "Content-Type: application/json" http://admin:secret-password@localhost:3000/api/v1/private/evaluate_target -d '{"country_code":"Russia", "target_group_id":6, "locations":[{"id":5, "panel_size": 1212}]}'```
* Request 4
  * ```curl -H "Content-Type: application/json" http://localhost:3000/api/v1/private/locations/Russia```
* Request 5
  * ```curl -H "Content-Type: application/json" http://localhost:3000/api/v1/private/target_groups/Russia```
