import 'package:flutter/material.dart';
import 'package:rendezvous/Functions/getAPIData.dart';
import 'package:rendezvous/View/Home/Panel.dart';
import 'package:rendezvous/View/MainMenu/GlocalPay/GlocalPay.dart';
import 'package:rendezvous/View/MainMenu/Result/Results.dart';
import 'package:rendezvous/View/Participant/Participant.dart';
import 'package:rendezvous/api/get_all_participation.dart';
import 'package:rendezvous/api/get_all_students.dart';
import 'package:rendezvous/api/get_participation.dart';
import 'package:rendezvous/api/get_programs.dart';
import 'package:rendezvous/api/get_teams.dart';
import 'package:rendezvous/api/utils_get.dart';
import 'package:rendezvous/inc/Constants.dart';

import '../../api/get_user_data.dart';

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

  getInitialData() async {
    await getUserData();
    await getParticipation();
    await getAllStudents();
    await getTeams();
    await getPrograms();
    await getTransactionFromAPI();
    await getAllParticipations();
    await getUtils();
  }

  @override
  void initState() {
    getInitialData();
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
