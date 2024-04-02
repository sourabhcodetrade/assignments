class InSufficientMoneyException implements Exception {
  final String message;

  const InSufficientMoneyException({required this.message});

  @override
  String toString() {
    return message;
  }
}

class BankAccount {
  int balance;
  BankAccount(this.balance);

  void withdraw(int amount) {
    if (amount > balance) {
      throw InSufficientMoneyException(
          message: "Current Balance ${balance} Withdrew Amount ${amount}");
    }

    balance -= amount;
    print("Success");
  }
}

void main() {
  BankAccount account = BankAccount(100);
  try {
    account.withdraw(150);
  } on InSufficientMoneyException catch (e) {
    print('InSufficientMoneyException: $e');
  } catch (e) {
    print('Error occurred: $e');
  }
}
