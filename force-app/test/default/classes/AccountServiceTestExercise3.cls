/* Instructions ************

1. Update the service and the repository to isolate update routine
- Add the update method in the repository interface
- Use the update method in the service
- Refactor updateAccount_givenAccountWithMore5000Employee_ReturnHotRating test so it is not integrated anymore
2. Implement unit test for the following test method :
- updateAccount_givenAccountWithMore5000Employee_ReturnHotRating
- updateAccount_givenAccountWithMore3000Employee_ReturnWarmRating
- updateAccount_givenAccountWithLess3000Employee_ReturnColdRating
- updateAccount_givenWrongAccount_ThrowsException

Goal: Refactor code using inversion of control, transform integrated code to not integratade code, unit test
Note: Decouple code from the DB and use apex-mockery to write unit test
Tips: Reuse what you saw in the step 1 and 2, use the getRandomId method to generate object with Id, ready for update
*/
@IsTest
private class AccountServiceTestExercise3 {
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

  // Generate ID for not integrated test purpose
  static Id getRandomId(SObjectType type) {
    final String prefix = type.getDescribe().getKeyPrefix();
    final String randomValue =
      '' + Integer.valueOf((Math.random() * 999999999));
    return Id.valueOf(prefix + randomValue.leftPad(12, '0'));
  }
}
