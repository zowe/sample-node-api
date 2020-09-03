const express = require('express');
const router = express.Router({ mergeParams: true });

const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('../swagger.json');
 
router.use('/api-docs-ui', function(req, res, next){
  swaggerDocument.host = req.get('host');
  req.swaggerDoc = swaggerDocument;
  next();
}, swaggerUi.serve, swaggerUi.setup());

router.use('/api-docs',function(req, res, next){
    swaggerDocument.host = req.get('host');
    res.send(swaggerDocument);
});

module.exports = router;
  