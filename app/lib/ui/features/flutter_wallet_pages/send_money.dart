import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class SendMoney extends StatefulWidget {
  final String name;
  final String avatar;
  const SendMoney({Key? key, required this.name, required this.avatar})
      : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  var amount = TextEditingController(text: "0.00");

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _editingController = TextEditingController();
  bool isFocused = false;

  final List<String> _feedbacks = [
    'Wow🙌',
    'I love this app🔥',
    'So futuristic 🤩',
    'My kyc was so easy 👍🏼',
  ];

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(onFocusChanged);
  }

  void onFocusChanged() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });

    print('focus changed.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Send Money',
            style: TextStyle(color: Colors.black),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                FadeInDown(
                  from: 100,
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    width: 130,
                    height: 130,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(widget.avatar)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                FadeInUp(
                    from: 60,
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Send Money To",
                      style: TextStyle(color: Colors.grey),
                    )),
                const SizedBox(
                  height: 10,
                ),
                FadeInUp(
                    from: 30,
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                FadeInUp(
                  from: 40,
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: TextField(
                      controller: amount,
                      textAlign: TextAlign.center,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      onSubmitted: (value) {
                        setState(() {
                          amount.text = "\$$value.00";
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (amount.text == "0.00") {
                            amount.text = "";
                          } else {
                            amount.text =
                                amount.text.replaceAll(RegExp(r'.00'), '');
                          }
                        });
                      },
                      inputFormatters: [ThousandsFormatter()],
                      decoration: InputDecoration(
                          hintText: "Enter Amount",
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // note textfield
                FadeInUp(
                  from: 60,
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 1000),
                  child: AnimatedContainer(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: isFocused
                              ? Colors.indigo.shade400
                              : Colors.grey.shade200,
                          width: 2),
                      // // boxShadow:
                    ),
                    child: TextField(
                      maxLines: 3,
                      focusNode: _focusNode,
                      controller: _editingController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FadeInUp(
                  from: 60,
                  delay: const Duration(milliseconds: 800),
                  duration: const Duration(milliseconds: 1000),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _feedbacks.length,
                      itemBuilder: (context, index) {
                        return FadeInRight(
                          from: 100,
                          delay: Duration(milliseconds: index * 500),
                          duration: const Duration(milliseconds: 1000),
                          child: BouncingWidget(
                            duration: const Duration(milliseconds: 100),
                            scaleFactor: 1.5,
                            onPressed: () {
                              _editingController.text = _feedbacks[index];
                              _focusNode.requestFocus();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.shade200, width: 2),
                              ),
                              child: Text(
                                _feedbacks[index],
                                style: TextStyle(
                                    color: Colors.grey.shade800, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/');
                        },
                        minWidth: double.infinity,
                        height: 50,
                        child: const Text(
                          "Send",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
