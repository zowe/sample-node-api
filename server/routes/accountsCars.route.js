/*
  This program and the accompanying materials are
  made available under the terms of the Eclipse Public License v2.0 which accompanies
  this distribution, and is available at https://www.eclipse.org/legal/epl-v20.html
  
  SPDX-License-Identifier: EPL-2.0
  
  Copyright IBM Corporation 2020
*/

const express = require('express');
const router = express.Router({ mergeParams: true });

const accountsCarsController = require('../controllers/accountsCars.controller');


// Add missing feature
// un-comment this to implement two new routes
// accounts/:id/cars & accounts/:id/cars/:id2

router.route('/cars')
    .get(accountsCarsController.getAll);

router.route('/cars/:_id')
    .get(accountsCarsController.get);


module.exports = router;