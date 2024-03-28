// This is just an inefficient, flat-file, fpo to show the concept of what could be an efficiency to be gained.

pub enum EnumCommonQuery {
  AuthenticateUser,
  GetGraphMetrics,
  GetProjectVersion,
  ShowUserAssociations,
  GenericQueryGoodForBothDatabaseTypes,
}

mod query_arango {
  use super::EnumCommonQuery;
  pub fn run_qry (q:EnumCommonQuery)->String {
    let mut ret_str = "Running ARANGO Query";
    // if q = EnumCommonQuery::GetGraphMetrics {
    match q {
      EnumCommonQuery::GetGraphMetrics => ret_str = "MUTATED ARANGO Query",
      _ => ret_str,
    }
  }
}

mod query_maria {
  use super::EnumCommonQuery;
  pub fn run_qry (q:EnumCommonQuery)->&str {
    let mut ret_str = "Running MARIA Query";
    // if q = EnumCommonQuery::GetGraphMetrics {
    match q {
      EnumCommonQuery::GetGraphMetrics => ret_str = "MUTATED MARIA Query",
      // EnumCommonQuery::GetGraphMetrics => ret_str = ret_str.to_owned() + "more return",
      _ => ret_str,
    }
  }
}


pub fn run_common_query (qry:EnumCommonQuery)->String {
  match qry { // some queries could only relational
    EnumCommonQuery::ShowUserAssociations | EnumCommonQuery::GetGraphMetrics => query_arango::run_qry(qry),
    EnumCommonQuery::GetProjectVersion | EnumCommonQuery::GetProjectVersion => query_maria::run_qry(qry),
    _ => { "we would have something in place to determine what db type was used last and default to running the ambiguos query on that one" }
  } 
}