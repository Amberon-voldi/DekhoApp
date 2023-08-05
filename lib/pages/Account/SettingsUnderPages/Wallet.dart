import 'package:dekho/Utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List transaction = ['dfdf', 'jnjn'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Get.bottomSheet(
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.black,
                  ),
                  child: Column(children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              child: Image.asset('assets/logo.png')),
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Sharing in Dekho',
                              style: GoogleFonts.dmSans(fontSize: 20)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Dekho is a platform to share your content with the world and earn. We also allow you to share your coins to your friends from your wallet.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                  fontSize: 15, color: Colors.grey[500])),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('learn more',
                              style: GoogleFonts.dmSans(
                                  fontSize: 15, color: Colors.pink)),
                        ],
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: (() {
                            Get.back();
                          }),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            child: Center(
                                child: Text('Got it',
                                    style: GoogleFonts.dmSans(
                                        fontSize: 15, color: Colors.white))),
                          )),
                    ),
                  ]),
                ),
                barrierColor: Colors.grey.withOpacity(0.2),
              );
            },
          ),
        ],
      ),
      body: ListView(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Balance',
                style:
                    GoogleFonts.dmSans(fontSize: 20, color: Colors.grey[500])),
            guserData!.coins == null
                ? Text('₹0', style: GoogleFonts.abel(fontSize: 30))
                : Text('₹' + guserData!.coins.toString(),
                    style: GoogleFonts.abel(fontSize: 30)),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text('Add Coins',
                    style: GoogleFonts.dmSans(color: Colors.pink)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.pink),
                        borderRadius: BorderRadius.circular(10)))),
            SizedBox(
              height: 15,
            ),
          ]),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bocdec('Scan QR Code', UniconsLine.qrcode_scan, () {}),
              bocdec('Your QR', Icons.qr_code_rounded, () {}),
              // bocdec('Send Coins', UniconsLine.arrow_up, () {}),
              bocdec('Withdraw', UniconsLine.money_withdraw, () {}),
            ],
          ),
        ),
        transactionCard(),
        Column(
          children: [
            for (var i = 0; i < transaction.length; i++)
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                width: double.infinity,
                child: ListTile(
                  style: ListTileStyle.list,
                  tileColor: Colors.grey[900],
                  leading: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      UniconsLine.arrow_up,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('₹' + '987',
                      style: GoogleFonts.dmSans(fontSize: 16)),
                  subtitle: Text('Transaction ID: ' + '987',
                      style: GoogleFonts.dmSans(fontSize: 12)),
                  trailing: Text('12/12/2021',
                      style: GoogleFonts.dmSans(fontSize: 12)),
                ),
              ),
          ],
        )
      ]),
    );
  }

  Widget bocdec(title, icon, Function onTap) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.pink, borderRadius: BorderRadius.circular(10)),
          child: Center(child: Icon(icon, color: Colors.white)),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(title, style: GoogleFonts.dmSans(fontSize: 10))
      ],
    );
  }

  Widget transactionCard() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Transaction History', style: GoogleFonts.dmSans(fontSize: 16)),
          Text('View All',
              style: GoogleFonts.dmSans(fontSize: 15, color: Colors.pink))
        ],
      ),
    );
  }
}
