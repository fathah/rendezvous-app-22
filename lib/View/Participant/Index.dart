import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/Home/Panel.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/GlocalPay.dart';
import 'package:rendezvous/View/MainMenu/Result/Results.dart';
import 'package:rendezvous/View/Participant/Participant.dart';
import 'package:rendezvous/inc/Constants.dart';

class ParticipantHomeIndex extends StatefulWidget {
  @override
  _ParticipantHomeIndexState createState() => _ParticipantHomeIndexState();
}

class _ParticipantHomeIndexState extends State<ParticipantHomeIndex> {
  List pages = [
    ParticipantHome(),
    Results(),
    GlocalPay(
      isHome: true,
    ),
    Panel(),
  ];

  getUserData() async {
    String cardNo = mainBox!.get('cardNo');

    await getJSONFromAPI("students").then((value) {
      for (var data in value) {
        if (data['card'] == cardNo) {
          mainBox!.put('team', data['team']);
          mainBox!.put('section', data['section']);
          mainBox!.put('campus', data['campus']);
          mainBox!.put('programList', data['programList']);
        }
      }
    });

    await getUserDataFromAPI(cardNo);
    await getTransactionFromAPI();
    await getProgramsFromAPI();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: MAIN_GREEN,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: MAIN_GREEN,
            icon: Icon(Icons.task_outlined),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            backgroundColor: MAIN_GREEN,
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Glocal Pay',
          ),
          BottomNavigationBarItem(
            backgroundColor: MAIN_GREEN,
            icon: Icon(Icons.person),
            label: 'Panel',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      body: pages[currentPage],
    );
  }
}
