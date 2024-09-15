import 'package:web_socket_channel/web_socket_channel.dart';

final WebSocketChannel channel = WebSocketChannel.connect(
  Uri.parse('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo'),
);