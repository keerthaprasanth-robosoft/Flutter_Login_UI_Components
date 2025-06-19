import 'package:flutter/material.dart';
import 'package:flutter_test_project/components/colors.dart';
import 'package:flutter_test_project/components/text_styles.dart';
import 'package:flutter_test_project/models/ticketsModel/ticket_details_response.dart';
import 'package:flutter_test_project/view_models/ticket_details_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class TicketDetailsScreen extends StatefulWidget {
  final String ticketId;
  final String ticketName;
  const TicketDetailsScreen({
    super.key,
    required this.ticketId,
    required this.ticketName,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TicketDetailsViewModel>(context, listen: false)
            .fetchTicketDetails(widget.ticketId));
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toUpperCase()) {
      case "HIGH":
        return Colors.red;
      case "MEDIUM":
        return Colors.orange;
      case "LOW":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty && _selectedImage == null) return;

    final viewModel =
        Provider.of<TicketDetailsViewModel>(context, listen: false);

    final newChat = TicketChat(
      user: "You", // Get this dynamically from logged-in user
      chatTime: "Now",
      replayMessage: messageText,
      image: _selectedImage != null ? _selectedImage!.path : "",
      alignment: "1",
    );

    // ✅ Add message and notify UI
    viewModel.addMessage(newChat);

    // Clear input fields
    _messageController.clear();
    setState(() {
      _selectedImage = null;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticketName, style: AppTextStyles.headline),
        foregroundColor: AppColors.backgroundColor,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.gradientColor),
        ),
      ),
      body: Consumer<TicketDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          } else if (viewModel.ticketDetails == null) {
            return const Center(child: Text("No details found"));
          } else {
            return Column(
              children: [
                _buildTicketHeader(viewModel.ticketDetails!.data.ticketHeader),
                _buildTicketSubject(
                    viewModel.ticketDetails!.data.ticketSubject),
                Expanded(
                    child:
                        _buildChat(viewModel.ticketDetails!.data.ticketChat)),
                _buildMessageInput(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.image, color: Colors.blueAccent),
            onPressed: _pickImage,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildTicketHeader(TicketHeader header) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(header.assignedImage.isNotEmpty
            ? header.assignedImage
            : "https://via.placeholder.com/50"), // Placeholder if no image
      ),
      title: Text("Assigned To: ${header.assignedTo}"),
      subtitle: Text("Created By: ${header.createdBy}"),
      trailing: Chip(
        label: Text(header.status),
        backgroundColor: header.status == "NEW" ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildTicketSubject(TicketSubject subject) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📌 Subject: ${subject.subject}",
                  style: AppTextStyles.headline
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Row(
                children: [
                  Icon(Icons.priority_high,
                      color: _getPriorityColor(subject.priority)),
                  const SizedBox(width: 5),
                  Text("Priority: ${subject.priority}",
                      style: AppTextStyles.bodyText.copyWith(fontSize: 16)),
                ],
              ),
              const Divider(height: 20, thickness: 1),

              Text("📝 Description:",
                  style: AppTextStyles.headline.copyWith(fontSize: 16)),
              const SizedBox(height: 5),

              // ✅ Use flutter_html package to render HTML content properly
              Html(
                data: subject.description,
                style: {
                  "table": Style(
                    backgroundColor: Colors.grey[200], // Table background
                    padding: HtmlPaddings.all(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  "td": Style(
                    border: Border.all(color: Colors.black12),
                    padding: HtmlPaddings.all(8),
                    fontSize: FontSize(14),
                  ),
                  "p": Style(
                    fontSize: FontSize(14),
                    color: Colors.black87,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChat(List<TicketChat> chats) {
    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      padding: const EdgeInsets.all(10),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        final bool isMe = chat.alignment == "1";

        return Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: isMe ? Colors.blueAccent : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (chat.image.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Image.network(chat.image, width: 150),
                  ),
                Text(chat.replayMessage,
                    style:
                        TextStyle(color: isMe ? Colors.white : Colors.black)),
                Text(chat.chatTime,
                    style: TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
        );
      },
    );
  }
}
