import 'package:flutter/material.dart';
import 'package:todo/util/cusbutton.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey,
      content: Container(
        width: 120,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // get user input
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  // counterStyle:,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // focusedBorder: const OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  // ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  labelText: "Add a new task",
                  labelStyle:
                      const TextStyle(fontSize: 20, color: Colors.white)),
            ),

            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // save button
                cusButton(text: "Save", onPressed: onSave),

                // const SizedBox(width: 0),

                // cancel button
                cusButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
