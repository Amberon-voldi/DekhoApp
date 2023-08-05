import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../../../Utils/variables.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({super.key});

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  String refercode = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReferCode();
  }

  getReferCode() async {
    if (guserData!.refercode == null) {
      // generate a new refer code
      final uuid = Uuid();
      final newrefercode = uuid.v1().substring(0, 8);
      refercode = newrefercode;
      if (mounted) setState(() {});
      final todoWithNewName = guserData!.copyWith(refercode: newrefercode);

      final request = ModelMutations.update(todoWithNewName);
      final response = await Amplify.API.mutate(request: request).response;
      if (response.data != null) {
        guserData = response.data;
        print('updated refer code');
      } else {
        print('failed to update refer code');
      }
    } else {
      refercode = guserData!.refercode.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Refer & Earn')),
      body: ListView(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://cdn.discordapp.com/attachments/919582268631162883/1063526285395120229/icons8-customers-64.png',
                width: 200,
                height: 200,
              ),
              Text(
                'Refer & Earn',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Invite your friends to join Dekho and earn 5 coins for each friend who joins',
                style: TextStyle(color: Colors.white, fontSize: 15),
                textAlign: TextAlign.center,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 1)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Refer Code: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    Text(refercode,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: '${guserData!.refercode}'));
                        Fluttertoast.showToast(msg: 'Copied to Clipboard');
                      },
                      child: Icon(
                        Icons.copy,
                        color: Colors.white,
                        size: 15,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        guserData!.referercode != null
            ? Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  Text('Got a referral code? Enter it here',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    decoration: InputDecoration(
                        hintText: 'Enter your referral code',
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.pink,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 1)
                        ]),
                    child: Text('Submit'),
                  )
                ]),
              )
            : Container(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  Text('You have already used a referral code',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'You have already used a referral code. You can\'t use another one',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      textAlign: TextAlign.center),
                ]),
              ),
      ]),
    );
  }
}
