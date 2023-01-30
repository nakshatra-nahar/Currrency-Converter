// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:currency_converter/functions/fetchRates.dart';
import 'package:currency_converter/models/ratesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class USDtoANY extends StatefulWidget {
  final rates;
  final Map currencies;
  const USDtoANY({super.key, required this.rates, required this.currencies});

  @override
  State<USDtoANY> createState() => _USDtoANYState();
}

class _USDtoANYState extends State<USDtoANY> {
  String dropdownValue = 'AUD';
  String answer = 'Converted Currency will be shown here :)';

  @override
  Widget build(BuildContext context) {
    TextEditingController usdController = TextEditingController();
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'USD To Any Currency',
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: ValueKey('usd'),
              keyboardType: TextInputType.number,
              controller: usdController,
              decoration: InputDecoration(
                label: Text('Enter USD'),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer = usdController.text +
                            ' USD = ' +
                            convertusd(widget.rates, usdController.text,
                                dropdownValue) +
                            ' ' +
                            dropdownValue;
                      });
                    },
                    child: Text('Convert'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            //Final Output
            SizedBox(height: 10),
            Container(child: Text(answer))
          ],
        ),
      ),
    );
  }
}
