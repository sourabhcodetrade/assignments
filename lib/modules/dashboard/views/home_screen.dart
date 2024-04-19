import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_example/modules/auth/controller/auth_controller.dart';
import 'package:supabase_example/modules/dashboard/controller/database_controller.dart';

import '../../../utils/routes.dart';
import '../widgets/chat_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Map<String, dynamic>> messages;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    messages = args['data'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            onPressed: () async {
              await AuthController().logOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginScreen,
                  (route) => false,
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Messages",
            style: TextStyle(
                color: Colors.black, fontSize: 32, fontWeight: FontWeight.w700),
          ),
          // Expanded(
          //   child: ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     physics: const BouncingScrollPhysics(),
          //     itemCount: messages.length,
          //     itemBuilder: (context, index) {
          //       final message = messages[index];
          //       return ChatMessageTile(message: message);
          //     },
          //   ),
          // ),

          // Expanded(
          //   child: Query(
          //     options: QueryOptions(
          //       document: gql(DatabaseController.readMessages),
          //     ),
          //     builder: (result, {fetchMore, refetch}) {
          //       if (result.hasException) {
          //         return Text(result.exception.toString());
          //       }
          //
          //       if (result.isLoading) {
          //         return const Center(child: CircularProgressIndicator(
          //           color: Colors.blueAccent,
          //         ));
          //       }
          //
          //
          //       final List<Map<String, dynamic>> messages =
          //           (result.data?['messagesCollection']?['edges'] ?? [])
          //               .map<Map<String, dynamic>>(
          //                   (edge) => edge['node'] as Map<String, dynamic>)
          //               .toList();
          //
          //       return ListView.builder(
          //         itemCount: messages.length,
          //         itemBuilder: (context, index) {
          //           final message = messages[index];
          //           return Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: ChatMessageTile(message: message),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: Subscription(
              options: SubscriptionOptions(
                document: gql(DatabaseController.readMessages),
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Text(result.exception.toString());
                }

                if (result.isLoading) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ));
                }

                return ResultAccumulator.appendUniqueEntries(
                  latest: result.data,
                  builder: (context, {results}) {
                    final List<Map<String, dynamic>> messages =
                        (result.data?['messagesCollection']?['edges'] ?? [])
                            .map<Map<String, dynamic>>(
                                (edge) => edge['node'] as Map<String, dynamic>)
                            .toList();
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChatMessageTile(message: message),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
