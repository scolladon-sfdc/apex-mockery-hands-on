public inherited sharing class DMLSObjectRepository implements SObjectRepository {
  public void doInsert(final SObject sob) {
    insert sob;
  }
  public SObject queryDb(final String query) {
    return Database.query(query);
  }
}
