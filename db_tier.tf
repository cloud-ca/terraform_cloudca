resource "cloudstack_network" "db_tier" {
    name = "db_tier"
    cidr = "10.10.2.0/24"
    network_offering = "${var.network_offering}"
    vpc = "${cloudstack_vpc.my_own_private_cloud.id}"
    zone = "${var.zone}"
    aclid = "${cloudstack_network_acl.acl_db.id}"
    project = "${var.project}"
}

resource "cloudstack_instance" "mysql01" {
    name = "mysql01"
    service_offering= "${var.compute_offering}"
    network = "${cloudstack_network.db_tier.id}"
    ipaddress = "10.10.2.10"
    template = "${var.compute_template}"
    zone = "${var.zone}"
    project = "${var.project}"
    user_data = "${file(\"cloudinit_db\")}"
}

resource "cloudstack_ipaddress" "mysql01" {
    vpc = "${cloudstack_vpc.my_own_private_cloud.id}"
    project = "${var.project}"
}

resource "cloudstack_port_forward" "mysql01" {
  ipaddress = "${cloudstack_ipaddress.mysql01.id}"

  forward {
    protocol = "tcp"
    private_port = 22
    public_port = 22
    virtual_machine = "${cloudstack_instance.mysql01.id}"
  }
}

output "mysql01" {
    value = "${cloudstack_ipaddress.mysql01.ipaddress}"
}
