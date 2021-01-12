provider "aws" {
  region = "us-west-1"
}

locals {
  security_group_rules = csvdecode(file("./module/security-group-rules.csv"))
}

resource "aws_security_group_rule" "windows_server_rules" {
  count = length(local.security_group_rules)

  security_group_id = "sg-1234"
  type              = local.security_group_rules[count.index].type
  protocol          = local.security_group_rules[count.index].protocol
  from_port         = local.security_group_rules[count.index].from
  to_port           = local.security_group_rules[count.index].to
  cidr_blocks       = [local.security_group_rules[count.index].cidr_blocks]
  description       = local.security_group_rules[count.index].comment
}