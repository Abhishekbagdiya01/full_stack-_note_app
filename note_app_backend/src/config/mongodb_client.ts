import { MongoClient, Db } from "mongodb";

let database: Db;

export async function connectTODatabase () {
    const url = "mongodb://localhost:27017"
    const client = new MongoClient(url)
    database = client.db("notedb")
    console.log("Connected successfully")
}

export function getDatabase (): Db {
    return database
};
