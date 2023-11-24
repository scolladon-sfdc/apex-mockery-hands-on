@IsTest
private class AccountServiceTestStep1 {
  @isTest
  static void createAccount_givenAccountWithMore5000Employee_ReturnHotRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 5001
    );

    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = dmlHandlerMock.spyOn('doInsert');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    sut.createAccount(subject);

    // Assert
    Assert.areEqual('Hot', subject.Rating, 'Rating should be "Hot"');
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
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 3001
    );
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = dmlHandlerMock.spyOn('doInsert');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    sut.createAccount(subject);

    // Assert
    Assert.areEqual('Warm', subject.Rating, 'Rating should be "Warm"');
    //Expect.that(doInsertSpy)
    //  .hasBeenCalledWith(
        
    // );
  }

  @isTest
  static void createAccount_givenAccountWithLess3000Employee_ReturnColdRating() {
    // Arrange
    final Account subject = new Account(
      Name = 'test',
      NumberOfEmployees = 2001
    );
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = dmlHandlerMock.spyOn('doInsert');

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    sut.createAccount(subject);

    // Assert
    Assert.areEqual('Cold', subject.Rating, 'Rating should be "Cold"');
    //Expect.that(doInsertSpy)
    //  .hasBeenCalledWith(
        
    // );
  }

  @isTest
  static void createAccount_givenWrongAccount_ThrowsException() {
    // Arrange
    final Account subject = new Account(Name = 'Wrong');
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy doInsertSpy = dmlHandlerMock.spyOn('doInsert');
    doInsertSpy.throwsException(new TestException('Wrong Account'));

    // System under test
    AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );


    // Act
    try {
      sut.createAccount(subject);
    } catch (Exception ex) {
      // Assert
      Assert.areEqual(
        'Cold',
        subject.Rating,
        'Rating should be "Cold" (default)'
      );
      Assert.isInstanceOfType(
        ex,
        TestException.class,
        'Exception should be TestException'
      );
      //Expect.that(doInsertSpy)
      //  .hasBeenCalledWith(...);
    }
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
