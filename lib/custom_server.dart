// ignore_for_file: avoid_print

import 'package:network_info_plus/network_info_plus.dart';
import 'package:socket_io/socket_io.dart';

class CustomServer {

  List<String> usernames = [];
  List<Map<String,String>> messages = [];

  Future<String> createServer(int port) async {
    String? wifiIp = await selfIP();
    print('wifi ip= $wifiIp');


    var io = Server(wifiIp!);

    io.on('connection', (socket) {
      socket.on('connected', (data) {
        print('data from client => $data');
        final String userName =  data['username'];
        usernames.add(userName);
        print(usernames);
        messages.insert(0, {
          'message': '$userName Join the Chat',
          'sender': 'Admin',
          'hours': DateTime.now().hour.toString(),
          'min': DateTime.now().minute.toString()
        });
        io.emit('newUser', userName);
      });
      socket.on('message', (data)  {
        print(data);
      messages.insert(0, {
      'message': data['message'],
      'sender': data['sender'],
      'hours': DateTime.now().hour.toString(),
      'min': DateTime.now().minute.toString()
      });
          io.emit('message', messages);
    });

      socket.on('disconnected', (data) {
        print('data from client => $data');
        final userName =  data['username'];
        usernames.remove(userName);
        messages.insert(0, {
          'message': '$userName left the Chat',
          'sender': 'Admin',
          'hours': DateTime.now().hour.toString(),
          'min': DateTime.now().minute.toString()
        });
        print("User $userName removed");
        io.emit('userLeft',userName);
        print(usernames);
      });
    });
    io.listen(port);
    return wifiIp;
  }


  Future<String?> selfIP() async {
    String? wifiIP = await NetworkInfo().getWifiIP();
    return wifiIP;
  }

}
