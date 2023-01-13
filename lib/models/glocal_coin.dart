import 'package:rendezvous/api/Glocal%20Coin/new_transaction.dart';

class GCTransaction {
  Future<bool> newTransaction(String to, String amount, String message,{bool isNew = false}) async {
    return await addNewTransactionToDB(to, amount, message,isNew);
  }
}
