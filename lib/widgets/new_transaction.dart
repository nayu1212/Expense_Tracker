import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);
    if (enterTitle.isEmpty || enterAmount < 0 || selectedDate == null) {
      return;
    }
    widget.addtx(
      enterTitle,
      enterAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void dateChooser() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        // margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                  decoration: InputDecoration(label: Text('Title')),
                  controller: titleController,
                  onSubmitted: (val) => submitData()),
              TextField(
                decoration: InputDecoration(label: Text('Amount')),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (val) => submitData(),
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Text(selectedDate == null
                          ? 'No date chosen'
                          : 'Date Picked :${DateFormat('dd-MM-yyyy').format(selectedDate)}'),
                    ),
                    TextButton(
                      onPressed: dateChooser,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: (submitData),
                child: Text("Add Transaction"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
