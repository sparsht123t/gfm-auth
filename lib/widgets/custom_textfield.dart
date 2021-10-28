

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfm_auth/firebase/customer_data_calls.dart';

import 'package:provider/provider.dart';



class CustomTextField extends StatefulWidget {
  final screenSize;
  final maxText;
  final minText;
  final height;
  final width;
  final hint;
  final screenName;

   CustomTextField({Key? key, this.screenSize, this.maxText, this.height, this.width, this.hint, this.minText, this.screenName, })
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDataCalls>(
      builder: (context, customerDataCalls, child) => Center(
        child: Container(
          height: widget.height != null ? widget.height * widget.screenSize.height : 0.08 * widget.screenSize.height,
          width: widget.width != null ? widget.width * widget.screenSize.width : 0.9 * widget.screenSize.width,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Row(
              children: [
                widget.screenName == 'phoneAuth' ?
                Row(
                  children: [
                    Container(
                        margin: EdgeInsetsDirectional.fromSTEB(0.03 * widget.screenSize.width, 0, 0, 0),
                        child: Text(
                          "+91",
                          style: TextStyle(fontSize: 0.025 * widget.screenSize.height, fontWeight: FontWeight.bold),
                        )),
                    VerticalDivider(
                      color: Colors.black,
                      endIndent: 0.02 * widget.screenSize.height,
                      indent: 0.02 * widget.screenSize.height,
                      thickness: 0.01 * widget.screenSize.width,
                    ),
                    SizedBox(
                      width: 0.01 * widget.screenSize.width,
                    ),
                  ],
                ) : Container(),
                SizedBox(
                  width: 0.03 * widget.screenSize.width,
                ),
                Container(
                    width: 0.55 * widget.screenSize.width,
                    child: Center(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            customerDataCalls.customer.name = value;
                          });
                          print(customerDataCalls.customer.name);
                        },
                        validator: (value) {
                          if (value!.length < widget.minText) {
                            print("error");
                          }
                          return null;
                        },
                        keyboardType: widget.screenName == "phoneAuth" ?TextInputType.phone : TextInputType.name,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(widget.maxText),
                        ],
                        style: TextStyle(fontSize: 0.025 * widget.screenSize.height),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey), border: InputBorder.none, hintText: widget.hint),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
