/*
  This program and the accompanying materials are
  made available under the terms of the Eclipse Public License v2.0 which accompanies
  this distribution, and is available at https://www.eclipse.org/legal/epl-v20.html
  
  SPDX-License-Identifier: EPL-2.0
  
  Copyright IBM Corporation 2020
*/

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