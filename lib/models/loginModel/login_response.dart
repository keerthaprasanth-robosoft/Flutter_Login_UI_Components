class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final Profile? profile;
  final Dashboard? dashboard;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    this.profile,
    this.dashboard,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'id': id,
      'username': username,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'image': image,
    };
  }
}

class Profile {
  final int? id;
  final String? firstname;
  final String? middlename;
  final String? lastname;
  final String? email;
  final String? type;
  final bool? isActive;

  Profile({
    this.id,
    this.firstname,
    this.middlename,
    this.lastname,
    this.email,
    this.type,
    this.isActive,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      email: json['email'],
      type: json['type'],
      isActive: json['is_active'] == 1,
    );
  }
}

class Dashboard {
  final int totalTicket;
  final int ticketOpen;
  final int ticketClose;

  Dashboard({
    required this.totalTicket,
    required this.ticketOpen,
    required this.ticketClose,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      totalTicket: json['total_ticket'],
      ticketOpen: json['ticket_open'],
      ticketClose: json['ticket_close'],
    );
  }
}
