import {Router} from 'express'
import {getFsn_moving} from '../controllers/fsn_moving.controller'

const router = Router()

router.get('/fsn_moving', getFsn_moving)

export default router