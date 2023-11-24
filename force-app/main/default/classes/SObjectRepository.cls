public interface SObjectRepository {
  void doInsert(final SObject sob);
  //void doUpdate(final SObject sob);
  SObject queryDb(final String query);
}
