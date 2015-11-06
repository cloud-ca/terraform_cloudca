resource "cloudstack_vpc" "my_own_private_cloud" {
    name = "my_own_private_cloud"
    cidr = "10.10.0.0/22"
    vpc_offering = "${var.vpc_offering}"
    zone = "${var.zone}"
    project = "${var.project}"
}

resource "cloudstack_network_acl" "acl_web" {
    name = "acl_web"
    vpc = "${cloudstack_vpc.my_own_private_cloud.id}"
}

resource "cloudstack_network_acl_rule" "acl_web_tier" {
  aclid = "${cloudstack_network_acl.acl_web.id}"

  rule {
    action = "allow"
    source_cidr = "0.0.0.0/0"
    protocol = "all"
    traffic_type = "egress"
  }
  rule {
    action = "allow"
    source_cidr = "0.0.0.0/0"
    protocol = "all"
    traffic_type = "ingress"
  }
}

resource "cloudstack_network_acl" "acl_db" {
    name = "acl_db"
    vpc = "${cloudstack_vpc.my_own_private_cloud.id}"
}

resource "cloudstack_network_acl_rule" "acl_db_tier" {
  aclid = "${cloudstack_network_acl.acl_db.id}"


  rule {
    action = "allow"
    source_cidr = "0.0.0.0/0"
    protocol = "all"
    traffic_type = "egress"
  }
  rule {
    action = "allow"
    source_cidr = "0.0.0.0/0"
    protocol = "all"
    traffic_type = "ingress"
  }
}
