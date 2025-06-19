import 'package:flutter/material.dart';
import 'package:flutter_test_project/components/api_service.dart';
import 'package:flutter_test_project/models/ticketsModel/ticket_details_response.dart';

class TicketDetailsViewModel extends ChangeNotifier {
  TicketDetails? _ticketDetails;
  bool _isLoading = true;
  String? _errorMessage;

  TicketDetails? get ticketDetails => _ticketDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTicketDetails(String ticketId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await ApiService.get('/ticket_view/$ticketId');
      _ticketDetails = TicketDetails.fromMap(data);
    } catch (e) {
      _errorMessage = 'Failed to load ticket details: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void addMessage(TicketChat newChat) {
    if (_ticketDetails != null) {
      _ticketDetails!.data.ticketChat
          .insert(0, newChat); // ✅ Insert at top for reverse chat
      notifyListeners(); // ✅ Ensure UI updates
    }
  }
}
