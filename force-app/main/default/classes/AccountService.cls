public inherited sharing class AccountService {
  protected SObjectRepository repository;

  public AccountService() {
    this(new DMLSObjectRepository());
  }

  @TestVisible
  private AccountService(final SObjectRepository repository) {
    this.repository = repository;
  }

  public Account createAccount(final String name, final Integer numberOfEmployees) {
    final Account accountToCreate = new Account(Name=name, NumberOfEmployees=numberOfEmployees);
    this.setRating(accountToCreate);
    this.repository.doInsert(accountToCreate);
    return accountToCreate;
  }

  public Account updateAccount(final Account accountToUpdate, final Integer numberOfEmployees) {
    accountToUpdate.NumberOfEmployees = numberOfEmployees;
    this.setRating(accountToUpdate);
    update accountToUpdate;
    return accountToUpdate;
  }

  public Account getAccountById(final Id accountId) {
    return (Account) this.repository.queryDb('SELECT Id FROM Account WHERE AccountId = :accountId');
  }

  private void setRating(final Account anAccount) {
    anAccount.Rating = anAccount.NumberOfEmployees > 5000
      ? 'Hot'
      : anAccount.NumberOfEmployees > 3000 ? 'Warm' : 'Cold';
    this.repository.doInsert(anAccount);
  }
}
