import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskflow_getx/controllers/counter_controller.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CounterController>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Obx(
              () => Text(
                "${controller.counter.value}",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.decrement();
                  },
                  child: Text("DEC -"),
                ),
              ),
              SizedBox(width: 10.0),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.resetCounter();
                  },
                  child: Text("RESET"),
                ),
              ),
              SizedBox(width: 10.0),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.increment();
                  },
                  child: Text("INC +"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
