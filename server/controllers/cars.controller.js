const carsService = require('../services/cars.service');

const get = function(req, res){
    res.send(carsService.get(req.params._id))
}

const getAll = function(req, res){
    res.send(carsService.getAll())
}

module.exports = {
    get,
    getAll
};