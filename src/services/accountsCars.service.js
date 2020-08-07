/*
  This program and the accompanying materials are
  made available under the terms of the Eclipse Public License v2.0 which accompanies
  this distribution, and is available at https://www.eclipse.org/legal/epl-v20.html
  
  SPDX-License-Identifier: EPL-2.0
  
  Copyright IBM Corporation 2020
*/

const data = require('../data');

const carsService = require('./cars.service');

const get = function(req){
    return getAll(req).find(car => car._id == req.params._id);
}

const getAll = function(req){
    const cars = carsService.getAll();

    const car_ids = data.Accounts_Cars
        .filter(
            row => row.Account_id == req.params.Account_id
        ).map(
            row => row.Car_id
        );

    return cars.filter(car => car_ids.includes(car._id));
}

module.exports = {
    get,
    getAll
};