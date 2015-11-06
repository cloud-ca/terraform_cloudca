resource "cloudstack_network" "web_tier" {
    name = "web_tier"
    cidr = "10.10.1.0/24"
    network_offering = "${var.network_offering}"
    vpc = "${cloudstack_vpc.my_own_private_cloud.id}"
    zone = "${var.zone}"
    aclid = "${cloudstack_network_acl.acl_web.id}"
    project = "${var.project}"
}

resource "cloudstack_instance" "wordpress01" {
    name = "wordpress01"
    service_offering= "${var.compute_offering}"
    network = "${cloudstack_network.web_tier.id}"
    ipaddress = "10.10.1.10"
    template = "${var.compute_template}"
    zone = "${var.zone}"
    project = "${var.project}"
    user_data = "${file(\"cloudinit_wordpress\")}"
    depends_on = [ "cloudstack_instance.mysql01" ]
}

resource "cloudstack_ipaddress" "wordpress01" {
    vpc = "${cloudstack_vpc.my_own_private_cloud.id}"
    project = "${var.project}"
}

resource "cloudstack_port_forward" "wordpress01" {
  ipaddress = "${cloudstack_ipaddress.wordpress01.id}"

  forward {
    protocol = "tcp"
    private_port = 80
    public_port = 80
    virtual_machine = "${cloudstack_instance.wordpress01.id}"
  }
  forward {
    protocol = "tcp"
    private_port = 443
    public_port = 443
    virtual_machine = "${cloudstack_instance.wordpress01.id}"
  }
}

output "wordpress01" {
    value = "${cloudstack_ipaddress.wordpress01.ipaddress}"
}
