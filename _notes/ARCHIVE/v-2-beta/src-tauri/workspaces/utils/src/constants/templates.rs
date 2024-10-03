use chrono::Utc;

const TEMPLATE_DQ:&str = "
[DownQuark]
version='0.0.0'
created=AAAAAA
updated=AAAAAA

[DownQuark.User]
db_lookup=''
last_active=''

[DownQuark.Products]
devqon='devqon/_devqon'
";

const TEMPLATE_DEVQON:&str = "
[devqon]
version='0.0.0'
install='AAAAAA'
updated='AAAAAA'

[devqon.session]
last_active=''

[[devqon.vision]]
only_most_recent='will be stored'
name=''
config_toml_file_path=''
";

pub fn make_template_config(template_kind:&str) -> String{
  println!("template+dq: {:?}", template_kind);
  let mut selected_template = match template_kind {
    "_dq" => TEMPLATE_DQ,
    "_devqon" => TEMPLATE_DEVQON,
    _ => "",
  };

  let datetime = Utc::now();
  let timestamp = datetime.timestamp();  

  let selected_template_binding = selected_template.replace("AAAAAA",&timestamp.to_string());
  selected_template = &selected_template_binding;
  selected_template.to_string()
}