import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: SignIn(),
    );
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          body: Center(
            child: FlatButton(
                onPressed: () async {
                  final signature = await SmsAutoFill().getAppSignature;
                  print(signature);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: Text("Sign In")),
          ),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _listenOtp();
    super.initState();
  }

  void _listenOtp() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // PhoneFieldHint(),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PinFieldAutoFill(
                decoration: UnderlineDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  colorBuilder:
                      FixedColorBuilder(Colors.black.withOpacity(0.3)),
                ),
                codeLength: 5,

                // onCodeSubmitted: (code) {},
                onCodeChanged: (code) {
                  print(code);
                },
              ),
            ),
            // Spacer(),
            // TextFieldPinAutoFill(
            //   currentCode: _code,
            //   onCodeChanged: (p0) {
            //     print(p0);
            //   },
            // ),
            Spacer(),
            ElevatedButton(
              child: Text('Listen for sms code'),
              onPressed: () async {
                await SmsAutoFill().listenForCode;
              },
            ),

            SizedBox(height: 8.0),
            Divider(height: 1.0),
          ],
        ),
      ),
    );
  }
}

// class CodeAutoFillTestPage extends StatefulWidget {
//   @override
//   _CodeAutoFillTestPageState createState() => _CodeAutoFillTestPageState();
// }
//
// class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
//     with CodeAutoFill {
//   String? appSignature;
//   String? otpCode;
//
//   @override
//   void codeUpdated() {
//     setState(() {
//       otpCode = code!;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     listenForCode();
//
//     SmsAutoFill().getAppSignature.then((signature) {
//       setState(() {
//         appSignature = signature;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final textStyle = TextStyle(fontSize: 18);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Listening for code"),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
//             child: Text(
//               "This is the current app signature: $appSignature",
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Builder(
//               builder: (_) {
//                 if (otpCode == null) {
//                   return Text("Listening for code...", style: textStyle);
//                 }
//                 return Text("Code Received: $otpCode", style: textStyle);
//               },
//             ),
//           ),
//           const Spacer(),
//         ],
//       ),
//     );
//   }
// }
