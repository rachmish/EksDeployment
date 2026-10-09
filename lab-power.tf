locals {
  state = var.lab_running ? "running" : "stopped"

  member_servers = {
    adcs       = aws_instance.adcs.id
    tpp        = aws_instance.tpp.id
    vsatellite = aws_instance.vsatellite.id
  }
}

# Domain Controller: starts first, stops last
resource "aws_ec2_instance_state" "dc" {
  instance_id = aws_instance.dc.id
  state       = local.state
}

# Everything else depends on the DC
resource "aws_ec2_instance_state" "members" {
  for_each    = local.member_servers
  instance_id = each.value
  state       = local.state

  depends_on = [aws_ec2_instance_state.dc]
}