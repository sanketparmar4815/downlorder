import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InstagramPage extends StatefulWidget {
  int i;

  InstagramPage(this.i, {super.key});

  @override
  State<InstagramPage> createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  TextEditingController link = TextEditingController();
  String varify =
      "https://www.instagram.com/reel/CvC1v3wqAxy/?igshid=MzRlODBiNWFlZA==";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("---- ---- --- --- ${widget.i}");
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
                      link.text = data!.text
                          .toString(); // this will paste "copied text" to textFieldController
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
                child: GestureDetector(
                  onTap: () {
                    if (widget.i == 0) {
                      if (ifInstagramFacebookreels(link.text) == true) {
                        print(" iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii ");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "This url is not found in instagram",
                            ),
                          ),
                        );
                      }
                    } else if (widget.i == 1) {
                      if (ifInstagramFacebookreels(link.text) == false) {
                        print(" ffffffffffffffffffffffffffffffffffffff ");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("This url is not found in facebook"),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("This url is not found "),
                        ),
                      );
                    }
                  },
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool? ifInstagramFacebookreels(String url) {
    final instagramReelsRegex = RegExp(
      r'^https?:\/\/(?:www\.)?instagram\.com\/(?:[a-zA-Z0-9_\.]+)\/reel\/?$',
      caseSensitive: false,
    );

    final facebookReelsRegex = RegExp(
      r'^https?:\/\/(?:www\.)?facebook\.com\/(?:watch\/\?v=|video\.php\?v=)([0-9]+)\/?$',
      caseSensitive: false,
    );

    if (instagramReelsRegex.hasMatch(url)) {
      return true;
    } else if (facebookReelsRegex.hasMatch(url)) {
      return false;
    } else {
      return null;
    }
  }

// void main() {
//   String url1 = 'https://www.instagram.com/username/reel/';
//   String url2 = 'https://www.facebook.com/watch/?v=123456789/';
//   String url3 = 'https://www.youtube.com/watch?v=abcdefghijk/';
//   String url4 = 'https://www.google.com/';
//
//   print(isInstagramReels(url1)); // Output: true
//   print(isInstagramReels(url2)); // Output: false
//   print(isInstagramReels(url3)); // Output: false
//   print(isInstagramReels(url4)); // Output: false
//
//   print(isFacebookReels(url1)); // Output: false
//   print(isFacebookReels(url2)); // Output: true
//   print(isFacebookReels(url3)); // Output: false
//   print(isFacebookReels(url4)); // Output: false
// }
}
