part of 'input_widgets_library.dart';

class DropdownFromListInput extends StatefulWidget {
  final List list;
  final String? hintText;
  final Widget? prefixIcon;
  final String? fieldName;
  final bool isMandotary;
  final String? validatorMsg;
  final String? selectedValue;
  final ValueChanged onChange;

  const DropdownFromListInput(
      {super.key,
      required this.list,
      required this.selectedValue,
      required this.onChange,
      this.hintText,
      this.prefixIcon,
      this.fieldName,
      this.validatorMsg,
      this.isMandotary = false});

  @override
  State<DropdownFromListInput> createState() => _DropdownFromListInputState();
}

class _DropdownFromListInputState extends State<DropdownFromListInput> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.selectedValue == "" ? null : widget.selectedValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null && widget.isMandotary) {
          return (widget.validatorMsg != null && widget.validatorMsg != "")
              ? widget.validatorMsg
              : widget.fieldName != null && widget.fieldName != ""
                  ? "${widget.fieldName} Field can't be Empty"
                  : "Field can't be Empty";
        } else {
          return null;
        }
      },
      items: widget.list
          .map((e) => DropdownMenuItem(
              value: e["value"], child: Text(e["text"].toString())))
          .toList(),
      onChanged: widget.onChange,
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
