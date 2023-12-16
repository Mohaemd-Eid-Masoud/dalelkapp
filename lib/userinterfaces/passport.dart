import 'package:loginui/userinterfaces/home.dart';
import 'package:flutter/material.dart';

class Dalelk0 extends StatefulWidget {
  @override
  _StepperPageState createState() => _StepperPageState();
}

class StepItem {
  final String title;
  final String content;
  //final String assetImage; // Add if you have images

  StepItem({
    required this.title,
    required this.content,
   // required this.assetImage,
  });
}

class _StepperPageState extends State<Dalelk0> {
  final List<StepItem> _steps = [
    StepItem(
      title: 'تسجيل الدخول إلى موقع وزارة الداخلية',
      content: 'افتح متصفح الويب الخاص بك وانتقل إلى موقع وزارة الداخلية المصرية. انقر فوق علامة التبويب "الخدمات الإلكترونية". انقر فوق "خدمات الأحوال المدنية". انقر فوق "استخراج تصريح سفر".',
    ),
    StepItem(
      title: 'تقديم الأوراق المطلوبة',
      content: 'قم بتحميل نسخ رقمية من المستندات التالية: أصل بطاقة الرقم القومي وصورة منها. أصل جواز السفر وصور منه. شهادة تأدية الخدمة العسكرية أو الإعفاء منها. أصل مذكرة السفر. توافر تصريح العمل أو الحج في البلد التي تريد السفر إليها. أصل تصريح سفر نموذج 14 ونسخة منه. انقر فوق زر "تقديم الطلب".',
    ),
    // Add more step items here
  ];
  
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحليل إجراءات استخراج تصريح السفر'),
      ),
      body: Stepper(
      steps: _steps.map((step) => Step(
        title: Text(step.title),
        content: Text(step.content),
        isActive: true, // All steps currently active in this example
        state: StepState.indexed, // Use index for custom completion logic
      )).toList(),
      onStepTapped: (int step) => setState(() =>0  ),
    ),
  );
  }
}
