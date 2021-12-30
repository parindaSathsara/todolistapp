class Users {
  final String user_name;

  Users(
      {required this.user_name});


  Map<String, dynamic> toUserMap() {

    return {
      'user_name': user_name,
    };
  }

}

