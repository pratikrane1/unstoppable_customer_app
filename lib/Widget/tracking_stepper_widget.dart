import 'package:flutter/material.dart';


import 'custom_stepper.dart';

class TrackingStepperWidget extends StatelessWidget {
  final String status;
  // final bool takeAway;
  TrackingStepperWidget({required this.status,});

  @override
  Widget build(BuildContext context) {
    int _status = -1;
    if(status == 'Processing') {
      _status = 0;
    }else if(status == 'Shipping') {
      _status = 1;
    }else if(status == 'delivered') {
      _status = 2;
    }else if(status == 'Canceled') {
      _status = 3;
    }

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        CustomStepper(
          title: 'Processing', isActive: _status > -1, haveLeftBar: false, haveRightBar: true, rightActive: _status > 0,
        ),
        CustomStepper(
          title: 'Shipping', isActive: _status > 0, haveLeftBar: true, haveRightBar: true, rightActive: _status > 1,
        ),
        CustomStepper(
          title: 'Deliverd', isActive: _status > 1, haveLeftBar: true, haveRightBar: _status==2 ? false : true, rightActive: _status > 2,
        ),
        _status == 2 ? Container():
        CustomStepper(
          title: 'Canceled', isActive: _status > 2, haveLeftBar: true, haveRightBar: false, rightActive: _status > 3,
        ),

      ]),
    );
  }
}
