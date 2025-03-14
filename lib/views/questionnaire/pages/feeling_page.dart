import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../widgets/questionnaire/continue_btn_widget.dart';
import '../../../viewmodels/questionnaire/feeling_page_viewmodel.dart';
import '../../../utils/colors.dart';

class FeelingPage extends StatelessWidget {
  final VoidCallback onContinue;

  const FeelingPage({super.key, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Consumer<FeelingViewModel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "We'd love to know how you're doing right now. Please tell us from 1 to 5 how do you feel right now.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 48),
              Text(
                viewModel.selectedValue.toString(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.fontBlackColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 1,
                      maximum: 5,
                      startAngle: 180,
                      endAngle: 0,
                      showTicks: false,
                      showLabels: true,
                      showLastLabel: true,
                      canScaleToFit: true,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 30,
                        color: AppColors.backgroundMeterColor,
                        // cornerStyle: CornerStyle.bothCurve,
                      ),
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 1,
                          endValue: viewModel.selectedValue.toDouble(),
                          color: AppColors.primaryColor,
                          startWidth: 30,
                          endWidth: 30,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        MarkerPointer(
                          value: viewModel.selectedValue.toDouble().clamp(1, 5),
                          markerType: MarkerType.circle,
                          color: AppColors.primaryColor,
                          markerHeight: 35,
                          markerWidth: 35,
                          enableDragging: true,
                          enableAnimation: true,
                          animationType: AnimationType.ease,
                          animationDuration: 250,
                          onValueChanged: (value) {
                            viewModel.updateFeelingValue(value.round());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 30),
              const Text(
                "Well done! From this meter you can know whether it is good or bad, but with our help you can improve it even better",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
              ContinueButton(onPressed: onContinue),
            ],
          ),
        );
      },
    );
  }
}
