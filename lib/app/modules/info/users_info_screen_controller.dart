// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
//
// import '../../utils/constants/constants.dart';
// import '../models/profile_model.dart';
//
// class UsersInfoController extends GetxController{
//   RxBool isLoading = true.obs;
//   RxList<ProfileModel> profileModel = <ProfileModel>[].obs;
//
//   void getData() async {
//     final response = await Constants.supabase.from('profiles').select('*');
//     for (var map in response) {
//       profileModel.add(ProfileModel(
//           id: map['id'],
//           username: map['username'],
//           createdAt: DateTime.parse(map['created_at'])));
//       profileModel.refresh();
//     }
//     print(profileModel[0]);
//     print('done');
//     isLoading.value = false;
//     print(isLoading.value);
//   }
//
// }