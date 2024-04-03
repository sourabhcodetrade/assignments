
class User {
  final String? email;
  final String uid;

  User({required this.email, required this.uid});

  //App(MyUser) - firebase
  // Map<String, dynamic> toJson() => {
  //       "email": email,
  //       "password": uid,
  //     };

// firebase - App(MyUser)
//   static User fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//
//     return User(
//         email: snapshot["email"],
//         password: snapshot["password"],
//         uid: snapshot["uid"]);
//   }
}
