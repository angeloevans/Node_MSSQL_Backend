const utils = require('../database/utils');
const sql = require('mssql');


import { getConnection } from "../database/connections";

export const getSales2 =  async (req, res) => {
    const pool = await getConnection();
    const sqlQueries = await utils.loadSqlQueries('./');
    const result = await pool.request().query(sqlQueries.fast_slow_non_moving)
    console.log(result);
    res.json(result.recordset);
};