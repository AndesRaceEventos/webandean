
import 'package:flutter/material.dart';
import 'package:webandean/utils/button/assets_boton_style.dart';
import 'package:webandean/utils/colors/assets_colors.dart';
import 'package:webandean/utils/text/assets_textapp.dart';
//Metodo builder ,optimiza y redibuja cada steeper 
class CustomStepper extends StatefulWidget {
  final int totalSteps;
  final List<Widget> stepContents;
  final List<String> options;

  CustomStepper({
    required this.totalSteps,
    required this.stepContents,
    List<String>? options,
  })  : assert(stepContents.length == totalSteps, 'Step contents must match total steps.'),
        options = options ?? [];

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < widget.totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.horizontal,
      physics: const ClampingScrollPhysics(),
      margin: EdgeInsets.only(bottom: 50),
      stepIconMargin: EdgeInsets.all(0),
      currentStep: _currentStep,
      onStepContinue: _nextStep,
      onStepCancel: _previousStep,
      onStepTapped: _onStepTapped,
      controlsBuilder: (context, details) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentStep > 0)
              ElevatedButton(
                style: buttonStyle2(backgroundColor: Colors.white),
                onPressed: _previousStep,
                child: const P2Text(text: 'Atrás', color: Colors.blue, fontSize: 13),
              ),
            if (_currentStep < widget.totalSteps - 1)
              ElevatedButton(
                style: buttonStyle2(backgroundColor: Colors.white),
                onPressed: _nextStep,
                child: P2Text(text: _currentStep == widget.totalSteps - 1 ? 'Guardar' : 'Siguiente',color: Colors.blue, fontSize: 13),
              ),
          ],
        );
      },
      steps: List.generate(widget.totalSteps, (index) {
        // Solo renderiza el contenido del paso actual para mejorar el rendimiento
        final content = _currentStep == index ? widget.stepContents[index] : Container();

        final color = _currentStep >= index ? Colors.green.shade700 : Colors.grey;
        final title = widget.options.isNotEmpty ? widget.options[index] : 'Paso ${index + 1}';

        return Step(
          title: Container(),
          stepStyle: StepStyle(
            connectorColor: color,
            errorColor: Colors.red,
            color: color,
          ),
          label: Container(
            constraints: const BoxConstraints(maxWidth: 70),
            child: P2Text(text:
              title,
              color: color, fontSize: 12,
              maxLines: 1,
              height: 0,
            ),
          ),
          content: content, // Solo renderiza el contenido si es el paso actual
          state: _currentStep >= index ? StepState.complete : StepState.indexed,
          isActive: index <= _currentStep,
        );
      }),
    );
  }
}

//TODOS metodo normal 

// import 'package:flutter/material.dart';
// import 'package:webandean/utils/text/assets_textapp.dart';

// class CustomStepper extends StatefulWidget {
//   final int totalSteps;
//   final List<Widget> stepContents;
//   final List<String> options; // Asegúrate de que esto esté definido como final


//   CustomStepper({
//     required this.totalSteps,
//     required this.stepContents,
//     List<String>? options, 
//   }) : assert(stepContents.length == totalSteps, 'Step contents must match total steps.'), 
//     options = options ?? [];

//   @override
//   _CustomStepperState createState() => _CustomStepperState();
// }

// class _CustomStepperState extends State<CustomStepper> {
//   int _currentStep = 0;

//   void _nextStep() {
//     if (_currentStep < widget.totalSteps - 1) {
//       setState(() => _currentStep++);
//     }
//   }

//   void _previousStep() {
//     if (_currentStep > 0) {
//       setState(() => _currentStep--);
//     }
//   }

//   void _onStepTapped(int step) {
//     setState(() {
//       _currentStep = step;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stepper(
//       type: StepperType.horizontal,
//       physics: ClampingScrollPhysics(),
//       margin: EdgeInsets.only(bottom: 50),
//       stepIconMargin: EdgeInsets.all(0),
//       currentStep: _currentStep,
//       onStepContinue: _nextStep,
//       onStepCancel: _previousStep,
//       onStepTapped: _onStepTapped,
//       controlsBuilder: (context, details) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             if (_currentStep > 0)
//               ElevatedButton(
//                 onPressed: _previousStep,
//                 child: Text('Atrás'),
//               ),
//             if (_currentStep < widget.totalSteps - 1)
//             ElevatedButton(
//               onPressed:  _nextStep,
//               child: Text(_currentStep == widget.totalSteps - 1 ? 'Guardar' : 'Siguiente'),
//             ),
//           ],
//         );
//       },
//       steps: List.generate(widget.totalSteps, (index) {
//         final e = widget.stepContents[index];
//         final color = _currentStep >= index ? Colors.red.shade400 : Colors.grey;
        
//         // Si las opciones están vacías, mostrar 'Paso X'
//         final title = widget.options.isNotEmpty ? widget.options[index] : 'Paso ${index + 1}';

//         return Step(
//           title: Container(),
//           stepStyle: StepStyle(
//             connectorColor: color,
//             errorColor: Colors.redAccent,
//             color: color,
//           ),
//           label: Container(
//             constraints: BoxConstraints(maxWidth: 70),
//             child: P2Text(
//               text: title,
//               color: color,
//               maxLines: 1,
//               fontSize: 12,
//             ),
//           ),
//           content: e,
//           state: _currentStep >= index ? StepState.complete : StepState.indexed,
//           isActive: index <= _currentStep,
//         );
//       }),
//     );
//   }
// }
