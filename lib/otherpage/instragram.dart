import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InstagramPage extends StatefulWidget {
  const InstagramPage({super.key});

  @override
  State<InstagramPage> createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  TextEditingController link = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter your URL",
                prefixIcon:
                    const Icon(Icons.link, color: Colors.black, size: 28),
                suffixIcon: IconButton(
                  onPressed: () async {
                    // await Clipboard.setData(const ClipboardData(text: '123'));
                    final data = await Clipboard.getData(Clipboard.kTextPlain);
                    setState(() {
                      link.text = data!.text.toString(); // this will paste "copied text" to textFieldController
                    });
                  },
                  icon: const Icon(Icons.paste),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45),
                ),
              ),
              controller: link,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "VIEW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "DOWNLORD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
