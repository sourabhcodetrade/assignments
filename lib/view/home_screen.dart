import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_example/view/widgets/text_form_field.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Razorpay _razorpay;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    amountController.dispose();
    mobileController.dispose();
    emailController.dispose();
    formKey1.currentState!.dispose();
    formKey2.currentState!.dispose();
    formKey3.currentState!.dispose();
    formKey4.currentState!.dispose();
    _razorpay.clear();
  }

  Future<void> onCheckout() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': (int.parse(amountController.text) * 100),
      'description': 'Fine T-Shirt',
      'name': nameController.text,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': mobileController.text,
        'email': emailController.text
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('error = ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    nameController.clear();
    amountController.clear();
    emailController.clear();
    mobileController.clear();
    Fluttertoast.showToast(
      msg: 'Payment Successful ${response.paymentId}',
      backgroundColor: Colors.green,
      gravity: ToastGravity.SNACKBAR,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
      msg: 'Payment Failed ${response.message}',
      backgroundColor: Colors.red,
      gravity: ToastGravity.SNACKBAR,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: 'External Wallet ${response.walletName}',
      backgroundColor: Colors.blueAccent,
      gravity: ToastGravity.SNACKBAR,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 100,
              ),
              ReusableTextFromField(
                  formKey1: formKey1,
                  amountController: nameController,
                  isNumber: false,
                  text: "Name",
                  hint: "ex. John Doe"),
              const SizedBox(
                height: 8,
              ),
              ReusableTextFromField(
                  formKey1: formKey2,
                  amountController: emailController,
                  isNumber: false,
                  text: "Email",
                  hint: "ex. xyz@gmail.com"),
              const SizedBox(
                height: 8,
              ),
              ReusableTextFromField(
                  formKey1: formKey3,
                  amountController: mobileController,
                  isNumber: true,
                  text: "Phone Number",
                  hint: "ex. 123456789"),
              const SizedBox(
                height: 8,
              ),
              ReusableTextFromField(
                  formKey1: formKey4,
                  amountController: amountController,
                  isNumber: true,
                  text: "Amount",
                  hint: "ex. 399"),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey1.currentState!.validate() &&
                      formKey2.currentState!.validate() &&
                      formKey3.currentState!.validate() &&
                      formKey4.currentState!.validate()) {
                    await onCheckout();
                  }
                },
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(8),
                  backgroundColor: MaterialStatePropertyAll(Colors.teal),
                ),
                child: Text(
                  'Make Payment',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
