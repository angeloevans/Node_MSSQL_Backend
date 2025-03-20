import sql from "mssql";

const dbSettings = {
    user: "sa",              // Username
    password: "",            // Your SQL Server password (replace with actual password)
    server: "",              // Your SQL Server instance (e.g., 'localhost', '192.168.1.1', or a cloud server address)
    database: "AdventureWorks2019", // Your database name
    options: {
        encrypt: false,      // Set to true if using Azure, false for local SQL Server
        trustServerCertificate: true, // Set to true to bypass certificate validation (useful for local or self-signed certificates)
    },
};

export async function getConnection() {
    try {
        // Establish a connection pool
        const pool = await sql.connect(dbSettings);
        return pool;
    } catch (error) {
        console.error("Database connection failed:", error);
        throw error;  // You can throw the error or handle it differently if needed
    }
}

export { sql };
