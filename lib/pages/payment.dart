import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String userEmail;

  PaymentPage({
    required this.image,
    required this.name,
    required this.price,
    required this.userEmail,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _firstName,
      _lastName,
      _creditCardNumber,
      _address,
      _city,
      _state,
      _zipCode;
  String? _selectedPaymentMethod;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Form'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _sectionTitle('Billing Info'),
              _buildTextField('First Name', (value) => _firstName = value),
              _buildTextField('Last Name', (value) => _lastName = value),
              _buildTextField(
                  'Credit Card Number', (value) => _creditCardNumber = value),
              _buildTextField('Address', (value) => _address = value),
              _buildTextField('City', (value) => _city = value),
              _buildTextField('State/Province', (value) => _state = value),
              _buildTextField('ZIP/Postal Code', (value) => _zipCode = value),
              const SizedBox(height: 20),
              _sectionTitle('Payment Method'),
              _paymentMethodTile('JazzCash', 'images/jazzcash.png'),
              _paymentMethodTile('SadaPay', 'images/sadapay.png'),
              _paymentMethodTile('PayPal', 'images/paypal.png'),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'I accept the terms and conditions of the service and the privacy policy',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndPlaceOrder,
                child: const Text('PLACE MY ORDER'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(String labelText, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
        onSaved: (value) => onSaved(value!),
      ),
    );
  }

  Widget _paymentMethodTile(String title, String imagePath) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ],
      ),
      value: title,
      groupValue: _selectedPaymentMethod,
      onChanged: (value) {
        setState(() {
          _selectedPaymentMethod = value as String?;
        });
      },
    );
  }

  void _validateAndPlaceOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedPaymentMethod == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a payment method')),
        );
        return;
      }
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please accept the terms and conditions')),
        );
        return;
      }
      _formKey.currentState?.save();
      PlaceOrder();
    }
  }

  Future<void> PlaceOrder() async {
    final orderItem = {
      'name': widget.name,
      'price': widget.price,
      'image': widget.image,
      'status': "Pending",
    };

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userEmail)
          .collection('orders')
          .add(orderItem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Placed Successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to Place Order: $e')),
      );
    }
  }
}
