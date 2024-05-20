const { MongoClient } = require('mongodb');

const uri = "mongodb+srv://app138709:ppf3sZgoeoryHqtY@cluster0.lfqeuvd.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
let db;

async function connectToDB() {
    if (!db) {
        const client = new MongoClient(uri, { useUnifiedTopology: true });
        await client.connect();
        db = client.db('live_chat_app'); // Use the correct database name
    }
    return db.collection('users'); // Ensure to return the users collection
}

async function findUser(query) {
    const usersCollection = await connectToDB();
    return usersCollection.findOne(query);
}

async function insertUser(user) {
    const usersCollection = await connectToDB();
    return usersCollection.insertOne(user);
}

module.exports = { findUser, insertUser };
