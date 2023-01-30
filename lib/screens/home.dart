import 'package:currency_converter/controller/AnyToAny.dart';
import 'package:currency_converter/controller/UsdToAny.dart';
import 'package:currency_converter/functions/fetchRates.dart';
import 'package:currency_converter/models/ratesModel.dart';
import 'package:flutter/material.dart';
import 'package:http/retry.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formkey = GlobalKey<FormState>();
  late Future<RatesModel> result;
  late Future<Map> getAllCurrencies;
  @override
  void initState() {
    setState(() {
      result = fetchRates();
      getAllCurrencies = getAllCurrenciesFun();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/currency.jpeg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: FutureBuilder<Map>(
                      future: getAllCurrencies,
                      builder: (context, Currsnapshot) {
                        if (Currsnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: [
                              USDtoANY(
                                currencies: Currsnapshot.data!, 
                                rates: snapshot.data!.rates,
                              ),
                              ANYtoANY(
                                currensies: Currsnapshot.data!, 
                                rates: snapshot.data!.rates,
                              )
                            ],
                          );
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
