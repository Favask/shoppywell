import 'package:shoppywell/src/data/repository/cart_repo_impl.dart';
import 'package:shoppywell/src/domain/repositories/cart_repo.dart';

class CartUseCAse {
  final CartRepository _repository= CartRepositoryImpl();

 Future<void> stripeMakePayment()async {
     _repository.stripeMakePayment();
  }
}
