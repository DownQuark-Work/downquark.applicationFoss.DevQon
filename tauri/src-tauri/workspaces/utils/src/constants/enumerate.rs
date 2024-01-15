// #[derive(Debug)]
pub enum EnumIconStatusType { _DQ, BUSY, }
impl EnumIconStatusType {
  pub fn to_bytes(&self) -> Vec<u8> {
    match self {
      Self::BUSY => include_bytes!("../../../../icons/status/busy.ico").to_vec(),
      _ => include_bytes!("../../../../icons/_downquark/icon.ico").to_vec(), // _DQ as default
    }
  }
}