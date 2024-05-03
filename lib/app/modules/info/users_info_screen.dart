import 'package:flutter/material.dart';
import 'package:supabase_chat_application/app/modules/models/profile_model.dart';
import '../../utils/constants/constants.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  List<ProfileModel> _profileModel = <ProfileModel>[];

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final response = await Constants.supabase.from('profiles').select('*');
    for (var map in response) {
      _profileModel.add(ProfileModel(
          id: map['id'],
          username: map['username'],
          createdAt: DateTime.parse(map['created_at'])));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Users'),
      ),
      body: _profileModel.isEmpty
          ? const Center(child: Constants.preloader)
          : ListView.builder(
              itemCount: _profileModel.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(_profileModel[index].username),
                    trailing: Text(
                      'Created: ${_profileModel[index].createdAt.day}/${_profileModel[index].createdAt.month}/${_profileModel[index].createdAt.year}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
