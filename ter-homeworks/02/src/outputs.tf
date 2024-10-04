output "vm_info" {
    value = {

        instansce_name_platform_fqdn = yandex_compute_instance.platform.fqdn  
        instance_name_platform_db_fqdn = yandex_compute_instance.platform-db.fqdn

        instansce_name_platform = yandex_compute_instance.platform.name  
        instance_name_platform_db = yandex_compute_instance.platform-db.name

        platform_ip = yandex_compute_instance.platform.network_interface.0.nat_ip_address    
        platform_db_ip = yandex_compute_instance.platform-db.network_interface.0.nat_ip_address

    }
}
