// ignore_for_file: avoid_print

import 'package:tlaloc/models/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r''' 
{
  "type": "service_account",
  "project_id": "tlaloc-3c65c",
  "private_key_id": "4543876b76fb34809f086bb4e1ae42915bb2ebbe",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCOn5t+SimVVloN\nO9cpua9TFKGj/jDCHzmUg74tV9f34G/zHlyeOry1WplwvST84cNnGMRD4Q9eh9yt\nlPrtqHSHV8Do/83WUxRdpImPLDK5XuhFhlLS6BXg9OZnk3rvTKYX7/s7L/3Sw3x/\nKo7OuB0ZJYyPxaEN1mzARd56Y5A7RTMdoFb39Q8hz7JpM67eZHn3ej8Jk4Td+a7G\nVVdPH+s66lYqgu4q2XvX7feChmNNqAZzSo00LVVUUXJ/t13Gly3UNTTxmTGMqXZd\nQO0I4lSn1GjRi7a4292Po/WneO/AF6ks6ork9uTYdrO+zXdi3MyqCaBXr9IyMnFU\n3f9XC7sBAgMBAAECggEABz4Tp1YcxnicGg/v3S6QuKdTjgBaeYEca25FOgg771p2\nVOI10dMpwgvXvuHb/vt38MRRMyE6ppI/opDuLSNgx36tTSewTDHr1tWEJsEX0lH/\neYhYrF0cv0+wY5IZrA04Yf7NwzOssAc9SzfeCKFQ2PYPLT3b79fzrc/efFiR+nB1\nvlhS1WrW3P3hA+sjiJkFHxuX6CbyDtsjgNR3uh9rCgOnsCz5lGlcW7TE1Axjs93j\naaVkR9rLyLNG8SAa10CNM3JRldd3f9z17wKkQU+C0IBf3A9G8273tzqUS3I1j88C\nAyGc2VCnETFLjEPxTyimf9ZpsOF+Anzjr6LzYQBwAQKBgQDEBHfKZSAEWiZZA8oh\nXeioUphBPDHobxhe8jOjDM/2+/TZ2dtOiw6tV3QFNpxT5OWR6RUcTf2xy3E+jaUT\n9tcr3oseCC5g6HLVJD6BCbKdLvKlTR51PwoGFXzDy24Ype0N/+zVdD7BRwrOI53w\nXzw3BKxdjB4nAP9ZyNm18ruUTQKBgQC6RGJN+mVUBhDjGqGYSphNU5jWISlw6PEh\nXphuNq+OmOfQ8YbfhH01fyissfl2xiz44iWZufMNHKPsOOn7tQcMup/bNQdTxRng\nTUXc7G9mPY9GQM0GML/A2L7seRSb3rzteQUYSsH0qCmvo9cZPLUSiBA4Y1L8HeZP\nMuQOAsnrhQKBgQChZzxsP9CZRNIGwgQSbY1B7KDKNpKx3ainpa+3NrmXmegH6keW\n6RHw0e4KzOj0e6o89zwWznFzkR1ycJfZVIvg56KN3Ba0XTMRJoMBJccZfqr2SgYm\nbP4H/HF7l2rUiOwldvLA4LM72w+epd1LLGAcvZBghxvc6glZGPWLyI+EkQKBgEu+\nZyNCgVXrqY5QVAnzu38mUW4xygJKF1P0fZPD1RvtfcbvkGLwI2JPtSCUttbfu4Xx\noEyk2vsn/FigxDVA5f79HOgs5i/gZKdbhN9TnfE7czmkPDsaM7+d4/WRPxorNzRy\nE+pO7BQrFdiAjYWLtC42+jGT4jj3h6IJFcfExotpAoGAFvYayk05TgpdwIeh/h/H\nZ2/F4NFT/pfztgrU6ZrVDLuyE3gn8LHe7pDubT8c+s/88ZVxgDbfUzCIv9m8x+ci\n46M1gySz7308TGMGs/NgKlbJdBTzcKNXGHlka3uli+Eg4ud2X38pC+BLn2+4buPG\n6hJkSiL5qk6yd1bCMqi3yz0=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@tlaloc-3c65c.iam.gserviceaccount.com",
  "client_id": "115562377934835565395",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40tlaloc-3c65c.iam.gserviceaccount.com"
}
  ''';
  // ignore: prefer_const_declarations
  static final _spreadsheetID = '1IOzgexdgx6Zp0ca-vKOcxVBRcrSNkRRfZGRjVvwmANo';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetID);
      _userSheet = (await _getWorkSheet(spreadsheet, title: 'Precipitación'))
          as Worksheet?;

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error $e');
    }
  }

  static Future _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}
