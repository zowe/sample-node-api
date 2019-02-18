const data = require('../../data');

const get = function(_id){
    return getAll().find(car => car._id == _id);
}

const getAll = function(){
    return data.Cars;
}

module.exports = {
    get,
    getAll
};