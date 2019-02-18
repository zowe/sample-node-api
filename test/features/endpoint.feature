@1
Feature: initial REST feature
  As a <role>
  I can <do something>
  So that <I can get some value>

Scenario: connect
  When I GET the endpoint "/"
  Then I should get a 200 with body
  """
  Hello World!
  """

Scenario: get cars
  When I GET the endpoint "/cars"
  Then I should get a 200 with body
  """
  [{"_id":0,"Name":"chevrolet chevelle malibu","Miles_per_Gallon":18,"Cylinders":8,"Displacement":307,"Horsepower":130,"Weight_in_lbs":3504,"Acceleration":12,"Year":"1970-01-01","Origin":"USA"},{"_id":1,"Name":"buick skylark 320","Miles_per_Gallon":15,"Cylinders":8,"Displacement":350,"Horsepower":165,"Weight_in_lbs":3693,"Acceleration":11.5,"Year":"1970-01-01","Origin":"USA"},{"_id":2,"Name":"plymouth satellite","Miles_per_Gallon":18,"Cylinders":8,"Displacement":318,"Horsepower":150,"Weight_in_lbs":3436,"Acceleration":11,"Year":"1970-01-01","Origin":"USA"},{"_id":3,"Name":"amc rebel sst","Miles_per_Gallon":16,"Cylinders":8,"Displacement":304,"Horsepower":150,"Weight_in_lbs":3433,"Acceleration":12,"Year":"1970-01-01","Origin":"USA"},{"_id":4,"Name":"ford torino","Miles_per_Gallon":17,"Cylinders":8,"Displacement":302,"Horsepower":140,"Weight_in_lbs":3449,"Acceleration":10.5,"Year":"1970-01-01","Origin":"USA"},{"_id":5,"Name":"ford galaxie 500","Miles_per_Gallon":15,"Cylinders":8,"Displacement":429,"Horsepower":198,"Weight_in_lbs":4341,"Acceleration":10,"Year":"1970-01-01","Origin":"USA"},{"_id":6,"Name":"chevrolet impala","Miles_per_Gallon":14,"Cylinders":8,"Displacement":454,"Horsepower":220,"Weight_in_lbs":4354,"Acceleration":9,"Year":"1970-01-01","Origin":"USA"},{"_id":7,"Name":"plymouth fury iii","Miles_per_Gallon":14,"Cylinders":8,"Displacement":440,"Horsepower":215,"Weight_in_lbs":4312,"Acceleration":8.5,"Year":"1970-01-01","Origin":"USA"},{"_id":8,"Name":"pontiac catalina","Miles_per_Gallon":14,"Cylinders":8,"Displacement":455,"Horsepower":225,"Weight_in_lbs":4425,"Acceleration":10,"Year":"1970-01-01","Origin":"USA"},{"_id":9,"Name":"amc ambassador dpl","Miles_per_Gallon":15,"Cylinders":8,"Displacement":390,"Horsepower":190,"Weight_in_lbs":3850,"Acceleration":8.5,"Year":"1970-01-01","Origin":"USA"}]
  """

Scenario: get car
  When I GET the endpoint "/cars/0"
  Then I should get a 200 with body
  """
  {"_id":0,"Name":"chevrolet chevelle malibu","Miles_per_Gallon":18,"Cylinders":8,"Displacement":307,"Horsepower":130,"Weight_in_lbs":3504,"Acceleration":12,"Year":"1970-01-01","Origin":"USA"}
  """

Scenario: get accounts
  When I GET the endpoint "/accounts"
  Then I should get a 200 with body
  """
  [{"_id":"0","name":{"first":"Deidre","last":"Hayes"},"email":"deidre.hayes@undefined.me","phone":"+1 (839) 577-3100","address":"507 Church Avenue, Heil, Wyoming, 1754"},{"_id":"1","name":{"first":"Maldonado","last":"Sellers"},"email":"maldonado.sellers@undefined.biz","phone":"+1 (834) 573-2841","address":"286 Hewes Street, Abiquiu, Maine, 2447"},{"_id":"2","name":{"first":"Elvia","last":"Aguilar"},"email":"elvia.aguilar@undefined.io","phone":"+1 (826) 486-2932","address":"457 Buffalo Avenue, Caberfae, Connecticut, 2648"},{"_id":"3","name":{"first":"Chris","last":"Mullins"},"email":"chris.mullins@undefined.org","phone":"+1 (884) 425-2397","address":"642 Vandalia Avenue, Driftwood, California, 213"},{"_id":"4","name":{"first":"Vargas","last":"Oneal"},"email":"vargas.oneal@undefined.info","phone":"+1 (893) 576-3106","address":"413 Bedford Avenue, Bynum, Federated States Of Micronesia, 1793"}]
  """

Scenario: get account
  When I GET the endpoint "/accounts/0"
  Then I should get a 200 with body
  """
  {"_id":"0","name":{"first":"Deidre","last":"Hayes"},"email":"deidre.hayes@undefined.me","phone":"+1 (839) 577-3100","address":"507 Church Avenue, Heil, Wyoming, 1754"}
  """

Scenario: get cars with account
  When I GET the endpoint "/accounts/0/cars"
  Then I should get a 200 with body
  """
  [{"_id":0,"Name":"chevrolet chevelle malibu","Miles_per_Gallon":18,"Cylinders":8,"Displacement":307,"Horsepower":130,"Weight_in_lbs":3504,"Acceleration":12,"Year":"1970-01-01","Origin":"USA"},{"_id":1,"Name":"buick skylark 320","Miles_per_Gallon":15,"Cylinders":8,"Displacement":350,"Horsepower":165,"Weight_in_lbs":3693,"Acceleration":11.5,"Year":"1970-01-01","Origin":"USA"}]
  """

Scenario: get cars with account
  When I GET the endpoint "/accounts/0/cars"
  Then I should get a 200 with body
  """
  [{"_id":0,"Name":"chevrolet chevelle malibu","Miles_per_Gallon":18,"Cylinders":8,"Displacement":307,"Horsepower":130,"Weight_in_lbs":3504,"Acceleration":12,"Year":"1970-01-01","Origin":"USA"},{"_id":1,"Name":"buick skylark 320","Miles_per_Gallon":15,"Cylinders":8,"Displacement":350,"Horsepower":165,"Weight_in_lbs":3693,"Acceleration":11.5,"Year":"1970-01-01","Origin":"USA"}]
  """

Scenario: get account
  When I GET the endpoint "/accounts/0/cars/0"
  Then I should get a 200 with body
  """
  {"_id":0,"Name":"chevrolet chevelle malibu","Miles_per_Gallon":18,"Cylinders":8,"Displacement":307,"Horsepower":130,"Weight_in_lbs":3504,"Acceleration":12,"Year":"1970-01-01","Origin":"USA"}
  """