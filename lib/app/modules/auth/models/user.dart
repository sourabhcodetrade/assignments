
class MyUser {
  final String email;
  final String password;
  final String uid;

  MyUser({required this.email, required this.password, required this.uid});

  //App(MyUser) - firebase
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "uid": uid,
      };

//firebase - App(MyUser)
//   static MyUser fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//
//     return MyUser(
//         email: snapshot["email"],
//         password: snapshot["password"],
//         uid: snapshot["uid"]);
//   }
}
