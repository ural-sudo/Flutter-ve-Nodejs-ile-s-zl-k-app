const express = require("express");

const bodyParser = require("body-parser");

const kelimeRoutes = require('./routes/kelime');

app = express();

app.use(bodyParser.json());

app.use('/',kelimeRoutes);

app.listen(8000, () => {
    console.log("server up");
})
/* sequelize.sync().then( result => {
    
    app.listen(8000);
})
.catch(err => {
    console.log(err);
}) */