const express = require('express');
const router = express.Router({ mergeParams: true });

const carsController = require('../controllers/cars.controller');

router.route('/')
    .get(carsController.getAll);

router.route('/:_id')
    .get(carsController.get);

module.exports = router;