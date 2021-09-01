data "external" "env" { program = ["jq", "-n", "env"] }

output "schematics_env" {
value = jsonencode(data.external.env)
}
