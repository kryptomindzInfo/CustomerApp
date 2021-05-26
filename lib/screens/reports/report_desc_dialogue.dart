import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/models/get_transaction_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReportDescDialog extends StatefulWidget {
  final History history;

  const ReportDescDialog({Key key, this.history}) : super(key: key);
  @override
  _ReportDescDialogState createState() => _ReportDescDialogState();
}

class _ReportDescDialogState extends State<ReportDescDialog> {

  bool isApiCalling= false;
  String code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child:Form(
        key: _formkey,
        child: Container(
          height: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(icon:Icon(Icons.close), onPressed: (){
                    Navigator.pop(context);
                  })),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Report',
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                        ),),
                    ),
                    dataWidget('Date : ', widget.history.timestamp.substring(0,10)),
                    dataWidget('Transaction ID: ', widget.history.value.txData[0].masterId),
                    dataWidget('Details : ', widget.history.value.txData[0].txDetails),
                    dataWidget('Transaction Type : ', widget.history.value.txData[0].txName),
                    widget.history.value.txData[0].txType=='DR'?dataWidget('Sent : ', "- XOF ${widget.history.value.txData[0].amount.toString()}",Colors.red):
                    dataWidget('Received : ',"+ XOF ${widget.history.value.txData[0].amount.toString()}",primaryColor),
                    dataWidget('Fees : ', widget.history.value.txData.length==2?"XOF ${widget.history.value.txData[1].amount.toString()}":'       -',Colors.red),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dataWidget(String key , String value, [Color color]){
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(
              text: key,
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              ),
            ),
            TextSpan(
                text: value,
                style: TextStyle(
                    color: color??Colors.black54,
                    fontSize: 18.0
                )
            ),

          ]
      ),
    );
  }
}

