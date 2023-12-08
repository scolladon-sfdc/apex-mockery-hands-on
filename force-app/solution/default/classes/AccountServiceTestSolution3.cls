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
private class AccountServiceTestSolution3 {
  @isTest
  static void updateAccount_givenAccountWithMore5000Employee_ReturnHotRating() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doUpdateSpy = repositoryMock.spyOn('doUpdate');
    final Account subject = new Account(Id=getRandomId(Account.SObjectType), Name='test');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account accountUpdated = sut.updateAccount(subject, 5001);

    // Assert
    Assert.areEqual('Hot', accountUpdated.Rating, 'Rating should be "Hot"');
    Expect.that(doUpdateSpy)
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 5001,
          Rating = 'Hot'
        )
      );
  }

  @isTest
  static void updateAccount_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doUpdateSpy = repositoryMock.spyOn('doUpdate');
    final Account subject = new Account(Id=getRandomId(Account.SObjectType), Name='test');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account accountUpdated = sut.updateAccount(subject, 3001);

    // Assert
    Assert.areEqual('Warm', accountUpdated.Rating, 'Rating should be "Warm"');
    Expect.that(doUpdateSpy)
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 3001,
          Rating = 'Warm'
        )
      );
  }

  @isTest
  static void updateAccount_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doUpdateSpy = repositoryMock.spyOn('doUpdate');
    final Account subject = new Account(Id=getRandomId(Account.SObjectType), Name='test');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account accountUpdated = sut.updateAccount(subject, 2000);

    // Assert
    Assert.areEqual('Cold', accountUpdated.Rating, 'Rating should be "Cold"');
    Expect.that(doUpdateSpy)
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 2000,
          Rating = 'Cold'
        )
      );
  }

  @isTest
  static void updateAccount_givenWrongAccount_ThrowsException() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doUpdateSpy = repositoryMock.spyOn('doUpdate');
    doUpdateSpy.throwsException(new TestException());
    
    // System under test
    final AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    try {
      final Account accountUpdated = sut.updateAccount(new Account(Id=getRandomId(Account.SObjectType)), 1);
    } catch (Exception ex) {
      // Assert
      Assert.isInstanceOfType(ex, TestException.class);
      Expect.that(doUpdateSpy)
        .hasBeenCalledWith(
          Argument.ofType(Account.getSObjectType())
        );
    }
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
