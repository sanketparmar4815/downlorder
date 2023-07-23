import 'package:downlorder/otherpage/instragram.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  TextEditingController link = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Text(locator<SharedPreferences>().getString('abc')??""),
          // Text(locator<PackageInfo>().appName),
          // Text(locator<PackageInfo>().packageName),
          // Text(locator<PackageInfo>().version),
          // Text(locator<PackageInfo>().buildNumber),
          // Text(locator<PackageInfo>().buildSignature),

          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ignore: duplicate_ignore
            children: [
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purple,
                      Colors.pink,
                      Colors.orange,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // ignore: inference_failure_on_instance_creation
                      Navigator.push(
                        context,
                        // ignore: inference_failure_on_instance_creation
                        MaterialPageRoute(
                          builder: (context) {
                            return const InstagramPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "INSTAGRAM",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color(0xff3b5998),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      // ignore: inference_failure_on_instance_creation
                      Navigator.push(
                        context,
                        // ignore: inference_failure_on_instance_creation
                        MaterialPageRoute(
                          builder: (context) {
                            return const InstagramPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Facebook",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
