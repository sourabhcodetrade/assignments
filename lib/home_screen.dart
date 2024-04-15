import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_app/payment.dart';
import 'package:payment_app/widget_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
  final formKey5 = GlobalKey<FormState>();
  final formKey6 = GlobalKey<FormState>();
  final formKey7 = GlobalKey<FormState>();
  List<String> currency = ['INR', 'USD', 'GBP', 'JPY'];
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController stateCodeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  String selectedCurrency = 'INR';

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the client side by calling Stripe API
      final data = await createPaymentIntent(
          name: nameController.text,
          address: addressController.text,
          pin: pinCodeController.text,
          city: cityController.text,
          state: stateCodeController.text,
          country: countryCodeController.text,
          currency: selectedCurrency,
          amount: (int.parse(amountController.text) * 100).toString());

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Set to true for custom flow
          customFlow: false,
          // Main params
          merchantDisplayName: 'Flutter Test',
          paymentIntentClientSecret: data['client_secret'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          "Payment App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ReusableTextFromField(
                        formKey1: formKey1,
                        amountController: amountController,
                        isNumber: true,
                        text: 'Amount',
                        hint: 'Ex. 100',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    DropdownMenu<String>(
                      controller: currencyController,
                      inputDecorationTheme: const InputDecorationTheme(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      initialSelection: currency.first,
                      dropdownMenuEntries: currency
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                      onSelected: (value) {
                        setState(() {
                          selectedCurrency = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ReusableTextFromField(
                  text: 'Name',
                  formKey1: formKey2,
                  amountController: nameController,
                  isNumber: false,
                  hint: 'Ex. Sourabh',
                ),
                const SizedBox(
                  height: 12,
                ),
                ReusableTextFromField(
                  text: 'Address',
                  formKey1: formKey3,
                  amountController: addressController,
                  isNumber: false,
                  hint: 'Ex. 1212 Delhi',
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ReusableTextFromField(
                        text: 'City',
                        formKey1: formKey4,
                        amountController: cityController,
                        isNumber: false,
                        hint: 'Ex. Delhi',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 5,
                      child: ReusableTextFromField(
                        text: 'State code',
                        formKey1: formKey5,
                        amountController: stateCodeController,
                        isNumber: false,
                        hint: 'Ex. RAJ',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ReusableTextFromField(
                        text: 'Country code',
                        formKey1: formKey6,
                        amountController: countryCodeController,
                        isNumber: false,
                        hint: 'Ex. IN',
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 5,
                      child: ReusableTextFromField(
                        text: 'Pin code',
                        formKey1: formKey7,
                        amountController: pinCodeController,
                        isNumber: true,
                        hint: 'Ex. 302002',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey1.currentState!.validate() &&
                        formKey2.currentState!.validate() &&
                        formKey3.currentState!.validate() &&
                        formKey4.currentState!.validate() &&
                        formKey5.currentState!.validate() &&
                        formKey6.currentState!.validate() &&
                        formKey7.currentState!.validate()) {
                      await initPaymentSheet();
                      try {
                       final details = await Stripe.instance.presentPaymentSheet();
                       print('Details = $details');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Payment Completed",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Payment Failed",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    }
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.teal),
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
