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
    match q {
      EnumCommonQuery::GetGraphMetrics => ret_str = "ARANGO Get Metrics For Graph query",
      _ => ret_str = ret_str,
    };
    ret_str.to_string()
  }
}

mod query_maria {
  use super::EnumCommonQuery;
  pub fn run_qry (q:EnumCommonQuery)->String {
    let mut ret_str = "Running MARIA Query";
    match q {
      EnumCommonQuery::AuthenticateUser => ret_str = "MARIA Authenticate User query",
      EnumCommonQuery::GetProjectVersion => ret_str = "MARIA Get Project Version query",
      _ => ret_str = ret_str,
    };
    ret_str.to_string()
  }
}


pub fn run_common_query (qry:EnumCommonQuery)->String {
  let ret_qry = match qry { // some queries could only relational
    EnumCommonQuery::ShowUserAssociations | EnumCommonQuery::GetGraphMetrics => query_arango::run_qry(qry),
    EnumCommonQuery::GetProjectVersion | EnumCommonQuery::AuthenticateUser => query_maria::run_qry(qry),
    _ => { "we would have something in place to determine what db type was used last and default to running the ambiguos query on that one".to_string() }
  };
  ret_qry
}