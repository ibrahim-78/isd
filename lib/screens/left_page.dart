import 'package:flutter/material.dart';
import 'package:overlapping_panels_demo/utils/data.dart';

class LeftPage extends StatelessWidget {
  const LeftPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 32, 32, 32),
        child: Row(
          children: [
            SizedBox(
              width: 67,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListView(
                  children: servers
                      .map((server) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 4),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.network(
                                  server,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )))
                      .toList(),
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[100]!))),
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: Center(
                            child: Text(
                              "AUB",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          )),
                      Expanded(
                        child: Material(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          child: ListView(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 16, left: 16, right: 0),
                                child: Text(
                                  'TEXT CHANNELS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey),
                                ),
                              ),
                              ...[
                                "Rules",
                                "Chats",
                                "Books",
                                "Tools",
                                "Tutorials/Pdfs",
                                "Events",
                                'Job/InternShips'
                              ].map((channel) => ListTile(
                                    leading: const Icon(Icons.tag),
                                    horizontalTitleGap: 0,
                                    title: Text(channel),
                                    onTap: () {},
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}
