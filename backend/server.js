const express = require('express');
const { MongoClient, ServerApiVersion } = require('mongodb');
const { Server } = require('socket.io');
const http = require('http');
const cors = require('cors');  // Import the cors package

const app = express();
app.use(express.json()); // To parse JSON bodies
app.use(cors()); // Enable CORS for all routes

// Use the user route
app.use('/', require('./routes/user.route'));
const uri = "mongodb+srv://app138709:ppf3sZgoeoryHqtY@cluster0.lfqeuvd.mongodb.net/Cluster0?retryWrites=true&w=majority";

// MongoDB Atlas URI and options
// const uri = "mongodb+srv://app138709:ppf3sZgoeoryHqtY@cluster0.lfqeuvd.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const client = new MongoClient(uri, {
    serverApi: {
        version: ServerApiVersion.v1,
        strict: true,
        deprecationErrors: true,
    }
});

async function run() {
    try {
        // Connect the client to the server
        await client.connect();
        // Send a ping to confirm a successful connection
        await client.db("admin").command({ ping: 1 });
        console.log("Pinged your deployment. You successfully connected to MongoDB!");

        const db = client.db('live_chat_app');

        // Create HTTP server and pass the Express app
        const server = http.createServer(app);
        const io = new Server(server);

        // Connect to socket.io
        io.on('connection', function (socket) {
            let chat = db.collection('chats');

            // Create function to send status
            sendStatus = function (s) {
                socket.emit('status', s);
            }

            // Get chats from mongo collection
            chat.find().limit(100).sort({ _id: 1 }).toArray(function (err, res) {
                if (err) {
                    throw err;
                }

                // Emit messages
                socket.emit('output', res);
            });

            // Handle input events
            socket.on('input', function (data) {
                let name = data.name;
                let message = data.message;

                // Check for name and message
                if (name == '' || message == '') {
                    // Send error status
                    sendStatus('Please enter a name and message');
                } else {
                    // Insert message
                    chat.insertOne({ name: name, message: message }, function () {
                        io.emit('output', [data]);

                        // Send status object
                        sendStatus({
                            message: 'Message sent',
                            clear: true
                        });
                    });
                }
            });

            // Handle clear
            socket.on('clear', function (data) {
                // Remove all chats from collection
                chat.deleteMany({}, function () {
                    socket.emit('cleared');
                });
            });
        });

        // Listen on port 4000
        server.listen(4000, () => {
            console.log('Server is running on port 4000');
        });
    } catch (err) {
        console.error(err);
    }
}

run().catch(console.dir);