import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:overlapping_panels/overlapping_panels.dart';
import 'package:overlapping_panels_demo/screens/left_page.dart';
import 'package:overlapping_panels_demo/screens/main_page.dart';
import 'package:overlapping_panels_demo/screens/right_page.dart';
import 'package:overlapping_panels_demo/widgets/footer_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                return const MainPage();
              },
            ),
          ),
          FooterWidget(footerOffset: footerOffset)
        ],
      ),
    );
  }
}
