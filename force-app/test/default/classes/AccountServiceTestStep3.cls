@IsTest
private class AccountServiceTestStep3 {
  @isTest
  static void updateAccount_givenAccountWithMore5000Employee_ReturnHotRating() {
    // Arrange

    // Act

    // Assert
  }

  @isTest
  static void updateAccount_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange

    // Act

    // Assert
  }

  @isTest
  static void updateAccount_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange

    // Act

    // Assert
  }

  @isTest
  static void updateAccount_givenWrongAccount_ThrowsException() {
    // Arrange

    // Act

    // Assert
  }

  class TestException extends Exception {
  }

  static Id getRandomId(SObjectType type) {
    final String prefix = type.getDescribe().getKeyPrefix();
    final String randomValue =
      '' + Integer.valueOf((Math.random() * 999999999));
    return Id.valueOf(prefix + randomValue.leftPad(12, '0'));
  }
}
