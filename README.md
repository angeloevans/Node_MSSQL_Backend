# Node.js MSSQL Backend

This project is a backend server built with **Node.js** and **Express**, using **Microsoft SQL Server (MSSQL)** for database management. It provides a set of API endpoints for interacting with the database and performing various queries.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Error Handling](#error-handling)
- [Contributing](#contributing)
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
  npm install

Configuration
The application requires a MSSQL database connection. You need to configure the connection details in an environment file (.env).

Create a .env file in the root directory of the project:
touch .env

Add the following configuration in the .env file:
DB_USER=your_database_user
DB_PASSWORD=your_database_password
DB_SERVER=localhost
DB_DATABASE=AdventureWorks2019

DB_USER: Your SQL Server username (e.g., sa for system administrator).
DB_PASSWORD: The password for the SQL Server user.
DB_SERVER: The server where your SQL Server is running (e.g., localhost or an IP address or a cloud address like your-server.database.windows.net).
DB_DATABASE: The name of the database you're connecting to (e.g., AdventureWorks2019).

