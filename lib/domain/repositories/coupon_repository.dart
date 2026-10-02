import 'package:dekho/domain/models/coupon.dart';

abstract class CouponRepository {
  Future<List<Coupon>> getAllCoupons();
  Future<List<Coupon>> getCouponsForProduct(String productId);
  Future<List<Coupon>> getCouponsForRetailer(String retailerName);
}
