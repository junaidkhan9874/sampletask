import 'package:flutter/material.dart';
import 'package:turing_task/utilis/app_utils.dart';
import 'package:turing_task/utilis/text_utils.dart';

class DialogWithInputFieldWidget extends StatefulWidget {
  final String? title;
  final Function? function;

  const DialogWithInputFieldWidget({Key? key, this.title, this.function}) : super(key: key);

  @override
  State<DialogWithInputFieldWidget> createState() => _DialogWithInputFieldWidgetState();
}

class _DialogWithInputFieldWidgetState extends State<DialogWithInputFieldWidget> {
  final TextUtils _textUtils = TextUtils();
  TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Color blueColor = const Color(0XFF3c3ccd);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController.text = widget.title!;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: showContainer(),
      ),
    );
  }

  showContainer() {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _textUtils.txt18(text: "Edit Your Name", color: Colors.black),
          const SizedBox(height: 20.0),
          Form(
            key: formKey,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextFormField(
                controller: textController,
                decoration: AppUtils().inputDecorationWithLabel("Name", Colors.white, borderRadius: 10.0),
                textCapitalization: TextCapitalization.words,
                maxLines: 1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 100.0,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.function!(textController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              child: _textUtils.txt14(text: "Submit", color: blueColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
