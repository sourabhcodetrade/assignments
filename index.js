import { Server } from "socket.io";
import express from "express";
import http from "http";

const app = express();
const server = http.createServer(app);
const io = new Server(server);
const port = 3000;
var messages = [];
var d = new Date();

io.on('connection', (socket) => {
    console.log('a user connected');
    const username = socket.handshake.query.username;
    console.log('Username ', username);
    socket.on('message', (data) => {
      
        console.log(data);
        messages.unshift({
            message: data.message,
            sender: data.sender,
            hours: d.getHours(),
            min: d.getMinutes(),
            // sentAt: Date.now()
        });
        
        console.log(messages);
        io.emit('message', messages);
    });
});




server.listen(port, () => {
    console.log(`listening on ${port}`);
});
