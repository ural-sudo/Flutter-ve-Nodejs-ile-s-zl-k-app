

/* const Kelime = require('../models/kelimee'); */
const Kelime = require('../models/kelime');

exports.getWords = async (req,res,next) => {

    try{
        Kelime.fetch()
        .then(result =>{
            res.json(result);
            console.log(result);
        })
        .catch(err=> {
            console.log(err);
        })
    }catch(error){
        console.log(error);
    }
}


exports.postWord = (req,res,next)=>{
    const id = Math.random();
    const ing = req.body.kelime_ing;
    const tr = req.body.kelime_turkce;
    const createdAt = new Date();
    const updatedAt = new Date();
    const kelime = new Kelime(id,ing,tr,createdAt,updatedAt);
    kelime.save()
    .then(result=>{
        res.json(kelime);
        console.log(kelime);
    })
    .catch(err=>{
        console.log(err);
    })
}
exports.findWord = (req,res,next) => {
    
   
    const kelime_ing = req.body.kelime_ing;

    Kelime.fetchWods(kelime_ing)
    .then(result=>{
        res.json(result);
        console.log(result);
    })
    .catch(err=>{
        console.log(err);
    })

}
