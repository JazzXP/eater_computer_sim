import 'package:eater_computer/src/components/led.dart';
import 'package:flutter/material.dart';

class ModuleTitle extends StatelessWidget {
  const ModuleTitle(this.title, {Key? key, this.input, this.output})
      : super(key: key);
  final String title;
  final bool? input;
  final bool? output;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            input != null
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: LED(
                          input!,
                          size: 6,
                        ),
                      ),
                      Text(
                        'I',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 8.0,
                        ),
                      ),
                    ],
                  )
                : Container(),
            output != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: LED(
                          output!,
                          size: 6,
                        ),
                      ),
                      Text(
                        'O',
                        style: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 8.0,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(title,
            style: TextStyle(
              fontSize: 20.0,
            ))
      ],
    );
  }
}
