import {Router} from 'express'
import {getAvgSales} from '../controllers/avg_sales.controller'

const router = Router()

router.get('/avg_sales', getAvgSales)

export default router