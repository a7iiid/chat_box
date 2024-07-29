import 'package:chat_app/core/assets.dart';
import 'package:chat_app/feturs/call/call.dart';
import 'package:chat_app/feturs/contacts/contacts.dart';
import 'package:chat_app/feturs/home/view/recent_message.dart';
import 'package:chat_app/feturs/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeProvider with ChangeNotifier {
  int selectedPage = 0;
  List<Widget> pages = [RecantMessages(), Call(), Contacts(), Settings()];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          Assets.imageMessage,
          color: Color(0xFF24786D),
        ),
        label: 'Message'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          Assets.imageCall,
          color: Color(0xFF797C7B),
        ),
        label: 'Calls'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          Assets.imageUser,
          color: Color(0xFF797C7B),
        ),
        label: 'Contacts'),
    BottomNavigationBarItem(
        icon: SvgPicture.asset(
          Assets.imageSettings,
          color: Color(0xFF797C7B),
        ),
        label: 'Settings'),
  ];
  Widget onTapNav(int index) {
    selectedPage = index;
    bottomItems = [
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.imageMessage,
            color: selectedPage == 0 ? Color(0xFF24786D) : Color(0xFF797C7B),
          ),
          label: 'Message'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.imageCall,
            color: selectedPage == 1 ? Color(0xFF24786D) : Color(0xFF797C7B),
          ),
          label: 'Calls'),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            Assets.imageUser,
            color: selectedPage == 2 ? Color(0xFF24786D) : Color(0xFF797C7B),
          ),
          label: 'Contacts'),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          Assets.imageSettings,
          color: selectedPage == 3 ? Color(0xFF24786D) : Color(0xFF797C7B),
        ),
        label: 'Settings',
      ),
    ];
    notifyListeners();
    return pages[index];
  }
}
