import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> bookRequest(Map<String,dynamic> bookingMap,String bookingId)async{
return _firestore
        .collection("guide_request")
        .doc(bookingId)
        .set(bookingMap);
  }

}
