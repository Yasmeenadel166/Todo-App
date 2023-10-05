class User {

  static const String collectionName = 'users';
  String? id;
  String? fullName;
  String? userName;
  String? email;

  User({this.id, this.fullName, this.email, this.userName});

  // Named Constructor                           // primary Constructor
  User.fromFireStore( Map<String , dynamic>? data) :this( //
    id : data?['id'],
    fullName : data?['fullName'],
    userName : data?['userName'],
    email : data?['email'],
  );

  // User.fromFireStore( Map<String , dynamic>? data){
  //   id = data?['id'];
  //   fullName = data?['fullName'];
  //   userName = data?['userName'];
  //   email = data?['email'];
  // }

  Map<String, dynamic> toFirestore() {
    return {
      //return map {}
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
    };
  }
}
