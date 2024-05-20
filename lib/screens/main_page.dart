import 'package:flutter/material.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
import 'package:overlapping_panels_demo/screens/chat_screen.dart';
import 'package:overlapping_panels_demo/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
import 'package:overlapping_panels_demo/screens/left_page.dart';
import 'package:overlapping_panels_demo/screens/main_page.dart';
import 'package:overlapping_panels_demo/widgets/footer_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Offset footerOffset = const Offset(0, 1);
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SliderDrawer(
            sliderBoxShadow:
                SliderBoxShadow(color: Colors.blue, blurRadius: 36),
            key: _key,
            sliderOpenSize: 329,
            appBar: SliderAppBar(
                drawerIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      if (_key.currentState!.isDrawerOpen == false) {
                        _key.currentState!.openSlider();
                        footerOffset = const Offset(0, 0);
                      } else if (_key.currentState!.isDrawerOpen == true) {
                        _key.currentState!.closeSlider();
                        footerOffset = const Offset(0, 1);
                      }
                    });
                  },
                  icon: Icon(Icons.menu),
                ),
                appBarColor: Colors.blue,
                title: Text('Title',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w700))),
            slider: Builder(builder: (context) {
              return const LeftPage();
            }),
            child: Builder(
              builder: (context) {
                return ChatScreen(university: 'LAU', channel: 'Chats');
              },
            ),
          ),
          FooterWidget(footerOffset: footerOffset)
        ],
      ),
    );
  }
}
