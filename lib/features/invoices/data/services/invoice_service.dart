import 'package:cab_zing/core/constants/api_constants.dart';
import 'package:cab_zing/core/services/secure_storage_service.dart';
import 'package:cab_zing/features/invoices/models/invoice_model.dart';
import 'package:dio/dio.dart';

class InvoiceService {
  final SecureStorageService storage;
  final Dio dio = Dio();

  InvoiceService(this.storage);

  Future<List<InvoiceModel>> fetchInvoices() async {
    final token = await storage.readFromSecureStorage('access_token');
    final userId = await storage.readFromSecureStorage('user_id');

    if (token == null) throw Exception('Authentication token not found');

    final response = await dio.post(
      '${ApiConstants.viknBooksBaseUrl}${ApiConstants.saleListPage}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        "BranchID": 1,
        "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
        "CreatedUserID": userId != null ? int.tryParse(userId) ?? 1 : 1,
        "PriceRounding": 2,
        "page_no": 1,
        "items_per_page": 10,
        "type": "Sales",
        "WarehouseID": 1
      },
    );

    if (response.data['StatusCode'] == 6000) {
      final List data = response.data['data'];
      return data.map((json) => InvoiceModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load invoices: ${response.data['StatusCode']}');
    }
  }
}
