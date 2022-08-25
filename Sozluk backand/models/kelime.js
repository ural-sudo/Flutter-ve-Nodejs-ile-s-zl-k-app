
const sql = require('mssql');

const cfg = require('../database/config');

module.exports = class Kelime{
    constructor(kelime_id,kelime_ing,kelime_turkce,createdAt,updatedAt){
        this.kelime_id=kelime_id,
        this.kelime_ing=kelime_ing,
        this.kelime_turkce=kelime_turkce,
        this.createdAt = createdAt,
        this.updatedAt = updatedAt

    }
    async save(){
        try{
            const connection = await sql.connect(cfg);
            const istek = await connection.request()
            .input('kelime_id',sql.Float,this.kelime_id)
            .input('kelime_ing',sql.NVarChar,this.kelime_ing)
            .input('kelime_turkce',sql.NVarChar,this.kelime_turkce)
            .input('createdAt',sql.DateTime,this.createdAt)
            .input('updatedAt',sql.DateTime,this.updatedAt)
            .query('insert into kelimes values(@kelime_id,@kelime_ing,@kelime_turkce,@createdAt,@updatedAt)')
            return istek.recordset;
        }catch(err){
            console.log(err);
        }
    }

    static async fetch() {
        try{
            const conn = await sql.connect(cfg);
            const istek = await conn.request()
            .query('select * from kelimes')
            return istek.recordset;
        }catch(error){
            console.log(error);
        }
    }
    static async fetchWods(ing){
        try{
            const conn = await sql.connect(cfg);
            const istek = await conn.request()
            .input('kelime_ing',sql.NVarChar,ing)
            .query("SELECT * FROM kelimes WHERE kelime_ing LIKE '%' + @kelime_ing + '%'")
            return istek.recordset;
        }catch(error){
            console.log(error);
        }
    }
}