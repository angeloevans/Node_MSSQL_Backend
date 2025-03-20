import express from 'express'
import config from './config'
//setup routes

import avgSalesRoutes from './routes/avg_sales.routes'
import fsn_movingRoutes from './routes/fsn_moving.routes'

const cors = require('cors');
const app = express();

//settings
app.set('port', config.port)

app.use(cors({
    origin:"http://localhost:3000", // or use * for all
}))

//use routes
app.use(avgSalesRoutes)
app.use(fsn_movingRoutes)

export default app