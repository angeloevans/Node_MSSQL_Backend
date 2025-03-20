//import app from './app'

import app from './src/app'
//import connection from './src/database/connections'

   app.listen(app.get('port'))

console.log('server port', app.get('port'))
