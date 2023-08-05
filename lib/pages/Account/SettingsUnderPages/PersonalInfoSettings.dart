import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dekho/Utils/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInfoSettings extends StatefulWidget {
  const PersonalInfoSettings({super.key});

  @override
  State<PersonalInfoSettings> createState() => _PersonalInfoSettingsState();
}

class _PersonalInfoSettingsState extends State<PersonalInfoSettings> {
  DateTime? dobpicked;
  String? pickedcountry;

  TextEditingController phonecontroller = TextEditingController(
      text: guserData!.phone == null
          ? 'Not Provided'
          : guserData!.phone!.isEmpty
              ? 'Not Provided'
              : guserData!.phone);

  TextEditingController emailcontroller = TextEditingController(
      text: guserData!.email == null
          ? 'Not Provided'
          : guserData!.email!.isEmpty
              ? 'Not Provided'
              : guserData!.email);

  // list of all countries

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Info'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(children: [
          Expanded(
              child: Container(
            child: Column(
              children: [
                _buildTextField(
                    'Email', 'Enter your email', emailcontroller, null, true),
                _buildTextField(
                    'Phone', 'Enter your phone', phonecontroller, null, true),
                _buildTextField(
                    'Country',
                    'Enter your country',
                    TextEditingController(
                        text: guserData!.country == null
                            ? pickedcountry == null
                                ? 'Not Provided'
                                : pickedcountry
                            : guserData!.country!), () {
                  Get.bottomSheet(
                      Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          width: 300,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                color: Colors.black,
                                child: ListTile(
                                  title: Text(
                                    'Select Country',
                                    style: GoogleFonts.dmSans(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: countries.values.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        onTap: () {
                                          setState(() {
                                            pickedcountry = countries.values
                                                .elementAt(index);
                                          });
                                          Get.back();
                                        },
                                        trailing: Text(
                                          countries.keys.elementAt(index),
                                        ),
                                        title: Text(
                                          countries.values.elementAt(index),
                                          style: GoogleFonts.dmSans(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ));
                                  },
                                ),
                              ),
                            ],
                          )),
                      backgroundColor: Colors.black,
                      barrierColor: Colors.grey.withOpacity(0.2),
                      elevation: 3);
                }, false),
                _buildTextField(
                    'BirthDay',
                    'Enter your Birthday',
                    TextEditingController(
                        text: dobpicked == null
                            ? guserData!.dob == null
                                ? 'Not Provided'
                                : DateTime.parse(guserData!.dob!)
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0]
                            : dobpicked!.toLocal().toString().split(' ')[0]),
                    () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          helpText: 'Select your Birthday',
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.dark(),
                              child: child!,
                            );
                          },
                          lastDate: DateTime.now())
                      .then((value) {
                    setState(() {
                      dobpicked = value;
                    });
                  });
                }, false),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text('Show Mature Content',
                      style: GoogleFonts.dmSans(color: Colors.white)),
                  trailing: Obx(() => CupertinoSwitch(
                      value: isadult.value ?? false,
                      onChanged: (value) async {
                        isadult.value = value;
                        // final request = ModelMutations.update(guserData!.copyWith(
                        //     showActivityStatus: isstatusallowd.value ?? false));
                        // final response =
                        //     await Amplify.API.mutate(request: request).response;
                        // guserData = response.data;
                        // Get.log(response.data.toString());
                      })),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                // save data
                Get.dialog(Center(
                    child: CircularProgressIndicator(
                  color: Colors.pink,
                )));
                final item = guserData!.copyWith(
                    dob: dobpicked == null
                        ? guserData!.dob
                        : dobpicked!.toString(),
                    country: pickedcountry == null
                        ? guserData!.country
                        : pickedcountry,
                    phone: phonecontroller.text.isEmpty ||
                            phonecontroller.text == 'Not Provided'
                        ? guserData!.phone
                        : phonecontroller.text,
                    email: emailcontroller.text == 'Not Provided' ||
                            emailcontroller.text.isEmpty
                        ? guserData!.email
                        : emailcontroller.text);
                final req = ModelMutations.update(item);
                final res = await Amplify.API
                    .mutate(request: req)
                    .response
                    .then((value) {
                  if (value.data != null) {
                    Get.back();
                    Get.back();
                    guserData = value.data;
                    Get.snackbar('Success', 'Data Updated');
                  } else {
                    Get.back();
                    Get.snackbar('Error', 'Something went wrong');
                  }
                });
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text('Save',
                        style: TextStyle(color: Colors.white, fontSize: 15))),
              ),
            ),
          ),
        ]));
  }

  final isadult = false.obs;
  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController editingController,
    Function? onTap,
    bool isenabled,
  ) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: TextField(
            enabled: isenabled,
            keyboardType: label == 'Phone'
                ? TextInputType.phone
                : label == 'Email'
                    ? TextInputType.emailAddress
                    : TextInputType.text,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              hintStyle: GoogleFonts.dmSans(color: Colors.white),
              labelStyle:
                  GoogleFonts.dmSans(color: Color.fromARGB(255, 180, 179, 179)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pink),
              ),
            ),
            textInputAction: TextInputAction.go,
            style: GoogleFonts.dmSans(color: Colors.white),
            cursorColor: Colors.pink,
            controller: editingController,
          ),
        ));
  }

  var countries = {
    "AF": "Afghanistan",
    "AX": "\u00c5land Islands",
    "AL": "Albania",
    "DZ": "Algeria",
    "AS": "American Samoa",
    "AD": "Andorra",
    "AO": "Angola",
    "AI": "Anguilla",
    "AQ": "Antarctica",
    "AG": "Antigua & Barbuda",
    "AR": "Argentina",
    "AM": "Armenia",
    "AW": "Aruba",
    "AU": "Australia",
    "AT": "Austria",
    "AZ": "Azerbaijan",
    "BS": "Bahamas",
    "BH": "Bahrain",
    "BD": "Bangladesh",
    "BB": "Barbados",
    "BY": "Belarus",
    "BE": "Belgium",
    "BZ": "Belize",
    "BJ": "Benin",
    "BM": "Bermuda",
    "BT": "Bhutan",
    "BO": "Bolivia",
    "BA": "Bosnia & Herzegovina",
    "BW": "Botswana",
    "BV": "Bouvet Island",
    "BR": "Brazil",
    "IO": "British Indian Ocean Territory",
    "VG": "British Virgin Islands",
    "BN": "Brunei",
    "BG": "Bulgaria",
    "BF": "Burkina Faso",
    "BI": "Burundi",
    "KH": "Cambodia",
    "CM": "Cameroon",
    "CA": "Canada",
    "CV": "Cape Verde",
    "BQ": "Caribbean Netherlands",
    "KY": "Cayman Islands",
    "CF": "Central African Republic",
    "TD": "Chad",
    "CL": "Chile",
    "CN": "China",
    "CX": "Christmas Island",
    "CC": "Cocos (Keeling) Islands",
    "CO": "Colombia",
    "KM": "Comoros",
    "CG": "Congo - Brazzaville",
    "CD": "Congo - Kinshasa",
    "CK": "Cook Islands",
    "CR": "Costa Rica",
    "CI": "C\u00f4te d\u2019Ivoire",
    "HR": "Croatia",
    "CU": "Cuba",
    "CW": "Cura\u00e7ao",
    "CY": "Cyprus",
    "CZ": "Czechia",
    "DK": "Denmark",
    "DJ": "Djibouti",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "EC": "Ecuador",
    "EG": "Egypt",
    "SV": "El Salvador",
    "GQ": "Equatorial Guinea",
    "ER": "Eritrea",
    "EE": "Estonia",
    "SZ": "Eswatini",
    "ET": "Ethiopia",
    "FK": "Falkland Islands",
    "FO": "Faroe Islands",
    "FJ": "Fiji",
    "FI": "Finland",
    "FR": "France",
    "GF": "French Guiana",
    "PF": "French Polynesia",
    "TF": "French Southern Territories",
    "GA": "Gabon",
    "GM": "Gambia",
    "GE": "Georgia",
    "DE": "Germany",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GR": "Greece",
    "GL": "Greenland",
    "GD": "Grenada",
    "GP": "Guadeloupe",
    "GU": "Guam",
    "GT": "Guatemala",
    "GG": "Guernsey",
    "GN": "Guinea",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HT": "Haiti",
    "HM": "Heard & McDonald Islands",
    "HN": "Honduras",
    "HK": "Hong Kong SAR China",
    "HU": "Hungary",
    "IS": "Iceland",
    "IN": "India",
    "ID": "Indonesia",
    "IR": "Iran",
    "IQ": "Iraq",
    "IE": "Ireland",
    "IM": "Isle of Man",
    "IL": "Israel",
    "IT": "Italy",
    "JM": "Jamaica",
    "JP": "Japan",
    "JE": "Jersey",
    "JO": "Jordan",
    "KZ": "Kazakhstan",
    "KE": "Kenya",
    "KI": "Kiribati",
    "KW": "Kuwait",
    "KG": "Kyrgyzstan",
    "LA": "Laos",
    "LV": "Latvia",
    "LB": "Lebanon",
    "LS": "Lesotho",
    "LR": "Liberia",
    "LY": "Libya",
    "LI": "Liechtenstein",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "MO": "Macao SAR China",
    "MG": "Madagascar",
    "MW": "Malawi",
    "MY": "Malaysia",
    "MV": "Maldives",
    "ML": "Mali",
    "MT": "Malta",
    "MH": "Marshall Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MU": "Mauritius",
    "YT": "Mayotte",
    "MX": "Mexico",
    "FM": "Micronesia",
    "MD": "Moldova",
    "MC": "Monaco",
    "MN": "Mongolia",
    "ME": "Montenegro",
    "MS": "Montserrat",
    "MA": "Morocco",
    "MZ": "Mozambique",
    "MM": "Myanmar (Burma)",
    "NA": "Namibia",
    "NR": "Nauru",
    "NP": "Nepal",
    "NL": "Netherlands",
    "NC": "New Caledonia",
    "NZ": "New Zealand",
    "NI": "Nicaragua",
    "NE": "Niger",
    "NG": "Nigeria",
    "NU": "Niue",
    "NF": "Norfolk Island",
    "KP": "North Korea",
    "MK": "North Macedonia",
    "MP": "Northern Mariana Islands",
    "NO": "Norway",
    "OM": "Oman",
    "PK": "Pakistan",
    "PW": "Palau",
    "PS": "Palestinian Territories",
    "PA": "Panama",
    "PG": "Papua New Guinea",
    "PY": "Paraguay",
    "PE": "Peru",
    "PH": "Philippines",
    "PN": "Pitcairn Islands",
    "PL": "Poland",
    "PT": "Portugal",
    "PR": "Puerto Rico",
    "QA": "Qatar",
    "RE": "R\u00e9union",
    "RO": "Romania",
    "RU": "Russia",
    "RW": "Rwanda",
    "WS": "Samoa",
    "SM": "San Marino",
    "ST": "S\u00e3o Tom\u00e9 & Pr\u00edncipe",
    "SA": "Saudi Arabia",
    "SN": "Senegal",
    "RS": "Serbia",
    "SC": "Seychelles",
    "SL": "Sierra Leone",
    "SG": "Singapore",
    "SX": "Sint Maarten",
    "SK": "Slovakia",
    "SI": "Slovenia",
    "SB": "Solomon Islands",
    "SO": "Somalia",
    "ZA": "South Africa",
    "GS": "South Georgia & South Sandwich Islands",
    "KR": "South Korea",
    "SS": "South Sudan",
    "ES": "Spain",
    "LK": "Sri Lanka",
    "BL": "St. Barth\u00e9lemy",
    "SH": "St. Helena",
    "KN": "St. Kitts & Nevis",
    "LC": "St. Lucia",
    "MF": "St. Martin",
    "PM": "St. Pierre & Miquelon",
    "VC": "St. Vincent & Grenadines",
    "SD": "Sudan",
    "SR": "Suriname",
    "SJ": "Svalbard & Jan Mayen",
    "SE": "Sweden",
    "CH": "Switzerland",
    "SY": "Syria",
    "TW": "Taiwan",
    "TJ": "Tajikistan",
    "TZ": "Tanzania",
    "TH": "Thailand",
    "TL": "Timor-Leste",
    "TG": "Togo",
    "TK": "Tokelau",
    "TO": "Tonga",
    "TT": "Trinidad & Tobago",
    "TN": "Tunisia",
    "TR": "Turkey",
    "TM": "Turkmenistan",
    "TC": "Turks & Caicos Islands",
    "TV": "Tuvalu",
    "UM": "U.S. Outlying Islands",
    "VI": "U.S. Virgin Islands",
    "UG": "Uganda",
    "UA": "Ukraine",
    "AE": "United Arab Emirates",
    "GB": "United Kingdom",
    "US": "United States",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VU": "Vanuatu",
    "VA": "Vatican City",
    "VE": "Venezuela",
    "VN": "Vietnam",
    "WF": "Wallis & Futuna",
    "EH": "Western Sahara",
    "YE": "Yemen",
    "ZM": "Zambia",
    "ZW": "Zimbabwe"
  };
}
