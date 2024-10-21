import 'package:crud_api/providers/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:crud_api/models/person_model.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController interestsController = TextEditingController();

  DateTime? selectedDate;
  bool _isLoading = false;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      List<String> interests = interestsController.text
          .split(',')
          .map((interest) => interest.trim())
          .toList();

      // Create a new Record with the form data
      final newPerson = Record(
        name: nameController.text,
        surname: surnameController.text,
        mobile: mobileController.text,
        idNumber: idNumberController.text,
        language: languageController.text,
        interests: interests,
        birthDate: _selectDate != null
            ? DateFormat('MM/dd/yyyy').format(selectedDate!)
            : null,
      );

      try {
        // Call the provider to store the new person via the API
        print(newPerson.name);
        await Provider.of<ItemProvider>(context, listen: false)
            .addItem(newPerson);
        Navigator.pop(context); // Go back to the previous screen on success
      } catch (error) {
        print(error.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Person'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'NAME', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: surnameController,
                  decoration: InputDecoration(
                      labelText: 'SURNAME', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the surname';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: idNumberController,
                  decoration: InputDecoration(
                      labelText: 'ID NUMBER', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the ID number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                      labelText: 'MOBILE', border: OutlineInputBorder()),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'EMAIL', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: languageController,
                  decoration: InputDecoration(
                      labelText: 'LANGUAGE', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the language';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: 'BIRTH DATE',
                        // Safely handle null without using the null check operator (!)
                        hintText: selectedDate != null
                            ? DateFormat('MM/dd/yyyy').format(
                                selectedDate!) // When a date is selected
                            : 'mm/dd/yyyy', // Placeholder when no date is selected
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (selectedDate == null) {
                          return 'Please select a birth date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: interestsController,
                  decoration: InputDecoration(
                      labelText: 'Interests (comma separated)',
                      border: OutlineInputBorder()),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _submitForm();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: const Text(
                          'Add Person',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: const Text(
                          'Cancel',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
