/* Instructions ************

Implement test for the following test method :
- createAccount_givenAccountWithMore3000Employee_ReturnWarmRating
- createAccount_givenAccountWithLess3000Employee_ReturnColdRating
- createAccount_givenWrongAccount_ThrowsException

Goal: Get a first touch with the apex-mockery stub mechanism
Note: Look at createAccount_givenAccountWithMore5000Employee_ReturnHotRating for inspiration
Tips: Follow comments inside each test to know what should be done
*/
@IsTest
private class AccountServiceTestSolution1 {
  @isTest
  static void createAccount_givenAccountWithMore5000Employee_ReturnHotRating() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = repositoryMock.spyOn('doInsert');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account accountCreated = sut.createAccount('test', 5001);

    // Assert
    Assert.areEqual('Hot', accountCreated.Rating, 'Rating should be "Hot"');
    Expect.that(doInsertSpy)
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 5001,
          Rating = 'Hot'
        )
      );
  }

  @isTest
  static void createAccount_givenAccountWithMore3000Employee_ReturnWarmRating() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = repositoryMock.spyOn('doInsert');
    
    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account accountCreated = sut.createAccount('test', 3001);

    // Assert
    Assert.areEqual('Warm', accountCreated.Rating, 'Rating should be "Warm"');
    Expect.that(doInsertSpy)
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 3001,
          Rating = 'Warm'
        )
      );
  }

  @isTest
  static void createAccount_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = repositoryMock.spyOn('doInsert');

    
    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account accountCreated = sut.createAccount('test', 2000);
  
    Expect.that(doInsertSpy)
      .hasBeenCalledWith(
        new Account(
          Name = 'test',
          NumberOfEmployees = 2000,
          Rating = 'Cold'
        )
      );
  }

  @isTest
  static void createAccount_givenWrongAccount_ThrowsException() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = repositoryMock.spyOn('doInsert');
    doInsertSpy.throwsException(new TestException());
    
    // System under test
    final AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    try {
      final Account accountCreated = sut.createAccount('test', 2000);
    } catch (Exception ex) {
      // Assert
      Assert.isInstanceOfType(ex, TestException.class);
      Expect.that(doInsertSpy)
        .hasBeenCalledWith(
          new Account(
            Name = 'test',
            NumberOfEmployees = 2000,
            Rating = 'Cold'
          )
        );
    }
  }

  class TestException extends Exception {
  }
}
