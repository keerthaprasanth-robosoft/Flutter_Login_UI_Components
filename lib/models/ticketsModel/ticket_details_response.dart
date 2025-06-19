import 'dart:convert';

class TicketDetails {
  final bool success;
  final TicketData data;
  final String message;

  TicketDetails({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TicketDetails.fromJson(String str) =>
      TicketDetails.fromMap(json.decode(str));

  factory TicketDetails.fromMap(Map<String, dynamic> json) => TicketDetails(
        success: json["success"] ?? false,
        data: TicketData.fromMap(json["data"]),
        message: json["message"] ?? "",
      );
}

class TicketData {
  final TicketHeader ticketHeader;
  final TicketSubject ticketSubject;
  final List<TicketChat> ticketChat;
  final List<User> user;

  TicketData({
    required this.ticketHeader,
    required this.ticketSubject,
    required this.ticketChat,
    required this.user,
  });

  factory TicketData.fromMap(Map<String, dynamic> json) => TicketData(
        ticketHeader: TicketHeader.fromMap(json["ticket_header"] ?? {}),
        ticketSubject: TicketSubject.fromMap(json["ticket_subject"] ?? {}),
        ticketChat: (json["ticket_chat"] as List<dynamic>?)
                ?.map((x) => TicketChat.fromMap(x))
                .toList() ??
            [],
        user: (json["user"] as List<dynamic>?)
                ?.map((x) => User.fromMap(x))
                .toList() ??
            [],
      );
}

class TicketHeader {
  final String status;
  final String createdBy;
  final String created;
  final String support;
  final String assignedImage;
  final String assignedTo;

  TicketHeader({
    required this.status,
    required this.createdBy,
    required this.created,
    required this.support,
    required this.assignedImage,
    required this.assignedTo,
  });

  factory TicketHeader.fromMap(Map<String, dynamic> json) => TicketHeader(
        status: json["status"] ?? "Unknown",
        createdBy: json["created_by"] ?? "N/A",
        created: json["created"] ?? "N/A",
        support: json["support"] ?? "N/A",
        assignedImage: json["assigned_image"] ?? "",
        assignedTo: json["assigned_to"] ?? "N/A",
      );
}

class TicketSubject {
  final String subject;
  final String priority;
  final String description;

  TicketSubject({
    required this.subject,
    required this.priority,
    required this.description,
  });

  factory TicketSubject.fromMap(Map<String, dynamic> json) => TicketSubject(
        subject: json["subject"] ?? "No subject",
        priority: json["priority"] ?? "Low",
        description: json["description"] ?? "",
      );
}

class TicketChat {
  final String user;
  final String chatTime;
  final String replayMessage;
  final String image;
  final String alignment;

  TicketChat({
    required this.user,
    required this.chatTime,
    required this.replayMessage,
    required this.image,
    required this.alignment,
  });

  factory TicketChat.fromMap(Map<String, dynamic> json) => TicketChat(
        user: json["user"] ?? "Unknown",
        chatTime: json["chat_time"] ?? "N/A",
        replayMessage: json["replay_message"] ?? "",
        image: json["image"] ?? "",
        alignment: json["alignment"] ?? "0",
      );
}

class User {
  final int id;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String email;
  final String? username;
  final String type;
  final String? phone;
  final String? avatar;
  final String? address;
  final String? country;

  User({
    required this.id,
    required this.firstname,
    this.middlename,
    required this.lastname,
    required this.email,
    this.username,
    required this.type,
    this.phone,
    this.avatar,
    this.address,
    this.country,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        firstname: json["firstname"] ?? "Unknown",
        middlename: json["middlename"],
        lastname: json["lastname"] ?? "",
        email: json["email"] ?? "",
        username: json["username"],
        type: json["type"] ?? "",
        phone: json["phone"],
        avatar: json["avatar"],
        address: json["address"],
        country: json["country"],
      );
}
