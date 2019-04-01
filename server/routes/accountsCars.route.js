const express = require('express');
const router = express.Router({ mergeParams: true });

const accountsCarsController = require('../controllers/accountsCars.controller');

/*
// Add missing feature
// un-comment this to implement two new routes
// accounts/:id/cars & accounts/:id/cars/:id2

router.route('/cars')
    .get(accountsCarsController.getAll);

router.route('/cars/:_id')
    .get(accountsCarsController.get);
*/

module.exports = router;