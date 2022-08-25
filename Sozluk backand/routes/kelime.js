
const express = require('express');
const kelimeController = require('../controllers/kelime');

const router = express.Router();

router.get('/kelime',kelimeController.getWords);
router.post('/kelime',kelimeController.postWord);
router.post('/ara',kelimeController.findWord);


module.exports  = router;