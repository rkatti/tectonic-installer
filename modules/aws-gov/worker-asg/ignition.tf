data "ignition_config" "main" {
  files = [
    "${data.ignition_file.node_resolv.id}",
    "${var.ign_installer_kubelet_env_id}",
    "${var.ign_max_user_watches_id}",
    "${var.ign_s3_puller_id}",
  ]

  systemd = [
    "${var.ign_docker_dropin_id}",
    "${var.ign_k8s_node_bootstrap_service_id}",
    "${var.ign_kubelet_service_id}",
    "${var.ign_locksmithd_service_id}",
  ]
}

data "template_file" "node_resolv" {
  template = "nameserver ${var.nameserver_ip}"
}

data "ignition_file" "node_resolv" {
  path       = "/etc/resolv.conf"
  mode       = 0644
  filesystem = "root"

  content {
    content = "${data.template_file.node_resolv.rendered}"
  }
}


