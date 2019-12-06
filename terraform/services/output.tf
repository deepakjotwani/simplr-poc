output "redis_host" {
  value = "${module.redis.host}"
}

output "redis_port" {
  value = "${module.redis.port}"
}

output "api_gateway_ip" {
  value = "${module.api_gateway.ip}"
}

output "ops_portal_ip" {
  value = "${module.ops_portal.ip}"
}

output "gke_cluster_name" {
  value = "${module.cluster.name}"
}

output "gke_cluster_ip" {
  value = "${module.cluster.endpoint}"
}

output "gke_cluster_ca_certificate" {
  value = "${module.cluster.cluster_ca_certificate}"
}

output "gke_cluster_token" {
  value = "${data.google_client_config.current.access_token}"
}
