const express = require('express');
const router = express.Router({ mergeParams: true });

const accountsController = require('../controllers/accounts.controller');
const accountsCarsRoute = require('./accountsCars.route');

router.route('/')
    .get(accountsController.getAll);

router.route('/:_id')
    .get(accountsController.get);

router.use('/:Account_id', accountsCarsRoute);

module.exports = router;