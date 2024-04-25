import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_example/modules/auth/controller/auth_controller.dart';
import '../../../provider/provider.dart';
import '../../../utils/routes.dart';
import '../widgets/chat_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final obj = Provider.of<DataHandlerProvider>(context, listen: false);
      obj.callApi();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final obj = Provider.of<DataHandlerProvider>(context, listen: true);
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Messages",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
          ),
          obj.isLoading
              ? const CircularProgressIndicator(
                  color: Colors.blueAccent,
                )
              : obj.dataModel.successState
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: obj.messages.length,
                        itemBuilder: (context, index) {
                          final message = obj.messages[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ChatMessageTile(message: message),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Card(
                        elevation: 5,
                        margin:
                            const EdgeInsets.only(left: 8, right: 8, top: 100),
                        child: Container(
                          width: double.infinity,
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Text(
                            obj.dataModel.exceptionMessage.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
