// ignore_for_file: avoid_print

import 'package:tlaloc/models/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r''' 
  {
  "type": "service_account",
  "project_id": "curious-set-343803",
  "private_key_id": "38d647e8db7755dd6404b78860d4c4969c4d2824",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCTqjjD+3hqTm/X\nR++NohsC318MnoZvbQCKFNEEmtneDPe+ONfXTqyxg9jx0UhL8f5qhcilE6AYbDVj\n/7xe+9qHDpvKwGG8PUE9R/vV0N0HElKdaMrFW5UO0AZUHBCfg91OZy+LxFJd381o\n8BJ8MsjfRdXdf0HRXJvIPdEq71tiuDA0jAObwVWLSgPLyGfKPGph4IPw2BWqQoHp\nofcveBUtoDBCu4M8A05LHOqznXD0xde1KWSAn3iD0p7yDBkC/uazddFlUliqwHXm\n4yMgM5436N137HJvxGZTRP+PJiYPo5/nYnVdRPclYxzwWU9/f91jDki2hMKjkhM1\ngn8IL2mbAgMBAAECggEAD1iie6O32Px73RjJyaNuQTcrrqkO+aePZcpSCrN5Lv2U\nBb3smKDBi9VTB5ajd9kXgsSSnK1UdxVP2yupzQlJpb2b7U9fGOwYyqCfiJIjVmfO\nFDPe1vH0pMxzy+v6wkk3B73rkBAAK2dl9qD0mtnATIv6dQGTuolwWzgpc9faXID1\nfijRycjJI37sTfdA0ttsMAvHtqqUqf5hiYVZ6BRq702lLFBw1XmTtoNQvgczokrF\ni6pFZ+AcSSvdS4c0LTnh7OizYLzmlSQbF1REEmW0MdoWKvqteMi9NQVuQyVmCCQ9\nPfYwnrMjxyFscDEx9kBOuzihC++J9HPfSmu68x3dkQKBgQDF/3Pq8IK+eMR6Ysgd\n2NdVfwIhvWfzq9Y+csZ6JrXgXiMhnH8c0vePA1oj0WRFvWyXB2FJnMVGJEh7CwdB\nQdWGj8txJhsyJeaOVUYnt3EBeU8BzlM5FMFqHsNOe6zbM5XO3XtkrKJGwwKxiiny\nGZaBNzQArOw2edvwC+3bsL4jGQKBgQC+7CChYpGVXtHE6dNrM+AsxgDvNTGKDHDd\n31BT+UxpEN3mK6TiX3vI5iX1GhQfGEmClrXpHs5GnyFBzmszhiYjLqefEx3Eh66P\nEwv/LjWQ/ynjSj99Gy6pJgMNjd4N8xWLfx4usB5K0OkGMZ2Ze1NanEJ13xn2CzKr\nlusSkKfc0wKBgGHQKPvPhUeDcczkL+hOz1I1RGBWqZv/L//5w4NkzETjPIfGQCWF\nMzc7eLRpJRgu1A5oXu92ux5Dnmrqr9LVKx8mumJTaOwFPTjjd5z3SqRnwVgrDYIN\ndt9uAx4qiuJfQYrIb8T0Y9aBUDtU/hPUAD4lf1M2GhtvZ+/WdNMrJUNBAoGBALxM\nLjJ9AJCNH95Rrw4/74y5DBrgH6fDdV2d7Z+kdFP7Kp7j1I7fFTqiojUGL2orjfSZ\np3fvxgmo0CgS6W+7ksmILhGZzPYTy3mYk3Btpq8Guc1NYSiGMpLoxoILtUGUyV73\nVFE/qeCoAer17DV/iEoJaxLNotEjYioRgm6g9K25AoGAN396F1LIR8MDFCOi6sYa\nrljRdnrbaVKQhFssvq3OQDvjnjec8vOaUyAbhkhgyGu6y37qrt/tAEvUsCUSbFxa\n/pZLpkwLHhG5biFP6f06fhHzcIerMf5l+MC74OIh/celcZ0k2IHb0MaIjCszVh2J\nuB6G5lrUA5AtAUeKiy9kJnY=\n-----END PRIVATE KEY-----\n",
  "client_email": "tlaloc@curious-set-343803.iam.gserviceaccount.com",
  "client_id": "104695046465308432424",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/tlaloc%40curious-set-343803.iam.gserviceaccount.com"
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
