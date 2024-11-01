import 'package:flutter/material.dart';
import 'package:webandean/utils/text/assets_textapp.dart';

class CustomStepper extends StatefulWidget {
  final int totalSteps;
  final List<Widget> stepContents;
  final List<String> options; // Asegúrate de que esto esté definido como final


  CustomStepper({
    required this.totalSteps,
    required this.stepContents,
    List<String>? options, 
  }) : assert(stepContents.length == totalSteps, 'Step contents must match total steps.'), 
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
      physics: ClampingScrollPhysics(),
      margin: EdgeInsets.only(bottom: 50),
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
                onPressed: _previousStep,
                child: Text('Atrás'),
              ),
            if (_currentStep < widget.totalSteps - 1)
            ElevatedButton(
              onPressed:  _nextStep,
              child: Text(_currentStep == widget.totalSteps - 1 ? 'Guardar' : 'Siguiente'),
            ),
          ],
        );
      },
      steps: List.generate(widget.totalSteps, (index) {
        final e = widget.stepContents[index];
        final color = _currentStep >= index ? Colors.red.shade400 : Colors.grey;
        
        // Si las opciones están vacías, mostrar 'Paso X'
        final title = widget.options.isNotEmpty ? widget.options[index] : 'Paso ${index + 1}';

        return Step(
          title: Container(),
          stepStyle: StepStyle(
            connectorColor: color,
            errorColor: Colors.redAccent,
            color: color,
          ),
          label: P3Text(
            text: title,
            color: color,
            maxLines: 1,
            fontWeight: FontWeight.bold,
          ),
          content: e,
          state: _currentStep >= index ? StepState.complete : StepState.indexed,
          isActive: index <= _currentStep,
        );
      }),
    );
  }
}
