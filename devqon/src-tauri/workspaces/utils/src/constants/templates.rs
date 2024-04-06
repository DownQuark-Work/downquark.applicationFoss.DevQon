use chrono::Utc;

const TEMPLATE_DQ:&str = "
[DownQuark]
version='0.0.0'
created=AAAAAA
updated=AAAAAA

[DownQuark.User]
name=''
email=''

[DownQuark.Products]
devqon='devqon/_devqon'
";

const TEMPLATE_DEVQON:&str = "
[devqon]
version='0.0.0'
install='AAAAAA'
updated='AAAAAA'

[[devqon.vision]]
name=''
conf_toml=''
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