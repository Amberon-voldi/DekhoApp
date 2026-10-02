import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dekho/domain/models/coupon.dart';
import 'package:dekho/domain/repositories/coupon_repository.dart';
import 'package:dekho/data/mock/mock_coupon_repository.dart';

final couponRepositoryProvider = Provider<CouponRepository>(
  (ref) => MockCouponRepository(),
);

final allCouponsProvider = FutureProvider<List<Coupon>>((ref) {
  return ref.watch(couponRepositoryProvider).getAllCoupons();
});

final productCouponsProvider = FutureProvider.family<List<Coupon>, String>((ref, productId) {
  return ref.watch(couponRepositoryProvider).getCouponsForProduct(productId);
});
