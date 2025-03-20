# Node.js MSSQL Backend

This project is a backend server built with **Node.js** and **Express**, using **Microsoft SQL Server (MSSQL)** for database management. It provides a set of API endpoints for interacting with the database and performing various queries.

## Table of Contents
- [Node.js MSSQL Backend](#nodejs-mssql-backend)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Load SQL Queries](#load-sql-queries)
    - [Functionality:](#functionality)
    - [Example Usage:](#example-usage)
    - [Error Handling](#error-handling)
    - [Contributing](#contributing)
    - [Fork the repository.](#fork-the-repository)
    - [License](#license)

## Prerequisites

Before you get started, make sure you have the following installed on your machine:

- **Node.js** (v14 or later): [Download Node.js](https://nodejs.org/)
- **Microsoft SQL Server** (or an accessible MSSQL instance). You can use [SQL Server Management Studio (SSMS)](https://aka.ms/ssmsfullsetup) or a cloud instance like [Azure SQL Database](https://azure.microsoft.com/en-us/services/sql-database/).

## Installation

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/angeloevans/Node_MSSQL_Backend.git
   cd Node_MSSQL_Backend
  
2. Install the dependencies:
    ```bash
    npm install


## Configuration
The application requires a MSSQL database connection. You need to configure the connection details in an connections.js.

1.  Create a .env file in the root directory of the project:
```bash
    touch .env
```

2. Add the following configuration in the .env file:

 ```bash
    NODE_ENV=development
    #express server config
    PORT=8081 #On which project will run
    HOST=localhost
    HOST_URL=http://localhost:8081
```

For MSSQL database connection :
`src/database/connections.js`

```js
user: "",              // Username
password: "",          // Your SQL Server password (replace with actual password)
server: "",            // Your SQL Server instance (e.g., 'localhost', '192.168.1.1', or a cloud server address)
database: "AdventureWorks2019", // Your database name

```
## Usage
Start the backend server:

 ```bash

npm start
```
The server will run on the port specified in the .env file or default to 8081. 
<br>Visit http://localhost:8081 to access the backend.

Test the connection and ensure the API is working by sending requests to the endpoints.

Example of running the application:
```bash

npm run dev  # If using nodemon for hot reloading
```
This will start the server, and it will automatically reload when changes are made.

API Endpoints <br>
The backend exposes various endpoints for interacting with the database. Some of the example routes include:

1. /avg-sales
<br>GET: Retrieve average sales data.
<br>Example Request:   
GET http://localhost:8081/avg-sales
    
2. /fsn-moving 
<br>GET: Retrieve fast-moving and slow-moving items.
<br>Example Request:
<br>GET http://localhost:8081/fsn-moving 

<br>
You can customize or add more endpoints as per your database and use cases.

## Load SQL Queries

The utils.js loads SQL queries dynamically from `.sql` files stored in the `src/database` folder. This allows you to store and manage SQL queries in separate files, making the code cleaner and easier to maintain.

### Functionality:

The `loadSqlQueries` function reads all `.sql` files in the specified folder and loads their contents into a JavaScript object. The key of each object is the filename (without the `.sql` extension), and the value is the content of the SQL query.

### Example Usage:

1. Place your `.sql` files in the `src/database/queries` folder (or any subfolder).
2. Call the `loadSqlQueries` function to load them:

```js
const { loadSqlQueries } = require('./src/database/connections');

const queries = await loadSqlQueries('queries');  // 'queries' is the folder containing .sql files

console.log(queries.getUser);  // Outputs the content of getUser.sql
```

### Error Handling
If the application cannot connect to the database or if an error occurs while handling requests, a proper error message will be sent in the response. You can customize this in the error handling middleware located in app.js.

### Contributing
We welcome contributions! If you'd like to contribute, feel free to fork the repository and create a pull request. When making changes, be sure to follow these steps:

### Fork the repository.
Create a feature branch (git checkout -b feature-name).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-name).
Create a new Pull Request.
### License
This project is licensed under the MIT License. See the LICENSE file for more details.
