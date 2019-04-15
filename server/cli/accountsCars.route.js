const express = require('express');
const router = express.Router({ mergeParams: true });

const accountsCarsController = require('../controllers/accountsCars.controller');

router.route('/cars')
    .get(accountsCarsController.getAll);

router.route('/cars/:_id')
    .get(accountsCarsController.get);

module.exports = router;