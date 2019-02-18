const data = require('../../data');

const get = function(_id){
    return getAll().find(account => account._id == _id);
}

const getAll = function(){
    return data.Accounts;
}

module.exports = {
    get,
    getAll
};