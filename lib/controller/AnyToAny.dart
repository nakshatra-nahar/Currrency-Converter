import 'package:currency_converter/functions/fetchRates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ANYtoANY extends StatefulWidget {
  final rates;
  final Map currensies;
  const ANYtoANY({super.key, required this.rates, required this.currensies});

  @override
  State<ANYtoANY> createState() => _ANYtoANYState();
}

class _ANYtoANYState extends State<ANYtoANY> {
  TextEditingController moneyController = TextEditingController();
    String answer = 'Converted Currency will be shown here :)';

  var dropdownValue1 = "USD";
  var dropdownValue2 = "INR";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Any To Any',
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 15),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: ValueKey('usd'),
              keyboardType: TextInputType.number,
              controller: moneyController,
              decoration: InputDecoration(
                label: Text('Enter Amount'),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue1,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    items: widget.currensies.keys
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
                        dropdownValue1 = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text('To'),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    items: widget.currensies.keys
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
                        dropdownValue2 = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
             SizedBox(height: 10),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    answer = '${moneyController.text} $dropdownValue1 ${convertany(widget.rates, moneyController.text,
                            dropdownValue1, dropdownValue2)} $dropdownValue2';
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
            SizedBox(height: 10),
            Container(child: Text(answer))
          ],
        ),
      ),
    );
  }
}
