import app from './app'

   app.listen(app.get('port'))

console.log('server port', app.get('port'))