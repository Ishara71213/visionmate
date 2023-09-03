part of 'input_widgets_library.dart';

class DateSelectorInput extends StatefulWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? fieldName;
  final bool isMandotary;
  final String? validatorMsg;

  const DateSelectorInput(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.fieldName,
      this.validatorMsg,
      this.isMandotary = false});

  @override
  State<DateSelectorInput> createState() => _DateSelectorInputState();
}

class _DateSelectorInputState extends State<DateSelectorInput> {
  DateTime dateTime = DateTime(1980, 1, 1);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String? formFieldValidator(value, String? validatorMsg, bool isMandotary) {
      if (isMandotary) {
        if (value!.isEmpty) {
          return (validatorMsg != null && validatorMsg != "")
              ? validatorMsg
              : widget.fieldName != null && widget.fieldName != ""
                  ? "${widget.fieldName} Field can't be Empty"
                  : "Field can't be Empty";
        } else {
          return null;
        }
      } else {
        if (value!.isEmpty) {
          return (validatorMsg != null && validatorMsg != "")
              ? validatorMsg
              : widget.fieldName != null && widget.fieldName != ""
                  ? "${widget.fieldName} Field can't be Empty"
                  : "Field can't be Empty";
        } else {
          return null;
        }
      }
    }

    return TextFormField(
      validator: (value) =>
          formFieldValidator(value, widget.validatorMsg, widget.isMandotary),
      style: kInputFieldText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: true,
      controller: widget.controller,
      onTap: () => {
        showCupertinoModalPopup(
            anchorPoint: const Offset(20, 100),
            context: context,
            builder: (BuildContext context) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 300,
                      child: CupertinoDatePicker(
                          backgroundColor: Colors.white,
                          initialDateTime: dateTime,
                          use24hFormat: true,
                          mode: CupertinoDatePickerMode.date,
                          onDateTimeChanged: (DateTime newTime) {
                            setState(() {
                              dateTime = newTime;
                              if (widget.controller != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(newTime);
                                widget.controller!.text = formattedDate;
                              }
                            });
                          }),
                    ),
                  ],
                ))
      },
      decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: kGrey,
          hintStyle: kInputFieldHintText,
          filled: true,
          fillColor: kInputFieldBgColor,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  width: 2, style: BorderStyle.solid, color: kLightGreyColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  width: 2, style: BorderStyle.solid, color: kErrorColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  width: 2, style: BorderStyle.solid, color: kErrorColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  width: 1.4,
                  style: BorderStyle.solid,
                  color: kLightGreyColor))),
    );
  }
}
