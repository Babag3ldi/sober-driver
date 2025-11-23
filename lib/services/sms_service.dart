import 'package:telephony_sms/telephony_sms.dart';

class SMSService {
  static final _sms = TelephonySMS();

  static Future<void> sendStart(String from) async {
    await _sms.sendSMS(
      phone: '+99365362074',
      message: 'Start: $from',
    );
  }

  static Future<void> sendFinish(String from, String to, int price, String time) async {
    await _sms.sendSMS(
      phone: '+99365362074',
      message: 'Finish: $from → $to\nTime: $time\nPrice: $price TMT',
    );
  }
}
