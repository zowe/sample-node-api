const accountsCarsService = require('../services/accountsCars.service');

const get = function(req, res){
    res.send(accountsCarsService.get(req));
}

const getAll = function(req, res){
    res.send(accountsCarsService.getAll(req));
}

module.exports = {
    get,
    getAll
};