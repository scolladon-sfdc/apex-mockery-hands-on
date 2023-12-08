/* Instructions ************

Implement test for the following test method :
- getAccountById_givenAccountId_returnsAccount
- getAccountById_givenOpportunityId_throwsException

Goal: Drive the stub behavior to returns and throws
Note: Reuse the same principles used in step 1
Tips: Look at the [returns](https://github.com/salesforce/apex-mockery/blob/main/force-app/recipes/classes/mocking/Returns.cls)
      and [throws](https://github.com/salesforce/apex-mockery/blob/main/force-app/recipes/classes/mocking/Throws.cls) samples.
*/
@IsTest
private class AccountServiceTestSolution2 {
  @isTest
  static void getAccountById_givenAccountId_returnsAccount() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy queryDbSpy = repositoryMock.spyOn('queryDb');
    final Id accountId = getRandomId(Account.SObjectType);
    queryDbSpy.returns(new Account(Name='test'));

    // System under test
    final AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    final Account account = sut.getAccountById(accountId);

    // Assert
    Assert.areEqual('test', account.name, 'Name should be "test"');
    Expect.that(queryDbSpy)
      .hasBeenCalledWith(
        new MatchStringContaining(':accountId')
      );
  }

  @isTest
  static void getAccountById_givenOpportunityId_throwsException() {
    // Arrange
    final Mock repositoryMock = Mock.forType(SObjectRepository.class);
    final MethodSpy queryDbSpy = repositoryMock.spyOn('queryDb');
    final Id opportunityId = getRandomId(Opportunity.SObjectType);
    queryDbSpy.throwsException(new TestException());

    // System under test
    final AccountService sut = new AccountService(
      (SObjectRepository) repositoryMock.stub
    );

    // Act
    try {
    final Account account = sut.getAccountById(opportunityId);
  } catch (Exception ex) {
    // Assert
    Assert.isInstanceOfType(ex, TestException.class);
    Expect.that(queryDbSpy)
      .hasBeenCalledWith(
        new MatchStringContaining(':accountId')
      );
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

  class MatchStringContaining implements Argument.Matchable {
    String stringToMatch;

    public Boolean matches(Object callArgument) {
      final String stringCalled = (String) callArgument;

      return stringCalled.contains(this.stringToMatch);
    }

    public MatchStringContaining(final Object callArgumentToMatch) {
      this.stringToMatch = (String) callArgumentToMatch;
    }
  }
}
