const data = require('../../data');

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