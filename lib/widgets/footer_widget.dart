import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final Offset footerOffset;

  const FooterWidget({Key? key, required this.footerOffset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 160),
        offset: footerOffset,
        child: SizedBox(
          height: 90,
          child: Material(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.public,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_pin,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.alternate_email,
                      color: Colors.white54,
                      size: 32,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CircleAvatar(
                      radius: 16,
                      foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/5024388?v=4"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }
}
