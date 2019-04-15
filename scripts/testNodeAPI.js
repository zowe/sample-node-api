const fetch = require('node-fetch');
fetch('https://mymainframe.ibm.com:18000/accounts', { method: 'GET' })
    .then(res => res.json()) // expecting a json response
    .then(json => console.log(json));