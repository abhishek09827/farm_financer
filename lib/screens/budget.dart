import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_financer/screens/budget_graph.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Analysis extends StatelessWidget {
  User? users=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<List<DailyExpense>>(
          future: fetchExpenses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpensePage(expenses: snapshot.data!,),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
  Future<List<DailyExpense>> fetchExpenses() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await _firestore.collection('users')
        .doc(users?.uid)
        .collection(
        "expense").orderBy('date').get();

    List<DailyExpense> expenses = querySnapshot.docs.map((doc) {
      print(doc['amount']);
      return DailyExpense(
          (doc['date'] as Timestamp).toDate(),
        (doc['amount'] as num).toDouble(),
        doc['isIncome'] as String,
      );
    }).toList();


    return expenses;
  }
}
