import 'package:dekho/domain/models/coupon.dart';
import 'package:dekho/domain/repositories/coupon_repository.dart';
import 'mock_coupons.dart';

class MockCouponRepository implements CouponRepository {
  @override
  Future<List<Coupon>> getAllCoupons() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockCoupons.where((c) => !c.isExpired).toList();
  }

  @override
  Future<List<Coupon>> getCouponsForProduct(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockCoupons
        .where((c) => !c.isExpired && (c.isUniversal || c.applicableProductIds.contains(productId)))
        .toList();
  }

  @override
  Future<List<Coupon>> getCouponsForRetailer(String retailerName) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return mockCoupons
        .where((c) => !c.isExpired && c.retailer.displayName == retailerName)
        .toList();
  }
}
