import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:calmity/bloc.navigation_bloc/navigation_bloc.dart';

void main() async {
  final client = Client(
    'gc43z8m5ssga',
    logLevel: Level.INFO,
  );

  await client.setUser(
    User(
      id: 'proud-butterfly-9',
      extraData: {
        'image':
            'https://getstream.io/random_png/?id=proud-butterfly-9&amp;name=Proud+butterfly',
      },
    ),
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoicHJvdWQtYnV0dGVyZmx5LTkifQ.epmU-l06qIrp5rN9REh12ntw4iq37sUooGfk2u9Ovuk',
  );

  final channel = client.channel('messaging', id: 'godevs');

  // ignore: unawaited_futures
  channel.watch();

  runApp(Chatroom(client, channel));
}

class Chatroom extends StatelessWidget with NavigationStates {
  final Client client;
  final Channel channel;

  Chatroom(this.client, this.channel);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
          child: widget,
          client: client,
        );
      },
      home: StreamChannel(
        channel: channel,
        child: ChannelPage(),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
