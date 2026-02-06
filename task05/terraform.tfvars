
tags = {
  Creator = "yasarmehmet_bagdatli@epam.com"
}

# Resource groups (each in a unique location)
resource_groups = {
  rg1 = {
    name     = "cmaz-wxu9jawu-mod5-rg-01"
    location = "West Europe"
    tags     = {}
  }
  rg2 = {
    name     = "cmaz-wxu9jawu-mod5-rg-02"
    location = "North Europe"
    tags     = {}
  }
  rg3 = {
    name     = "cmaz-wxu9jawu-mod5-rg-03"
    location = "East US"
    tags     = {}
  }
}

# App Service plans: ASP1 (2 workers, S1), ASP2 (1 worker, S1)
app_service_plan = {
  asp1 = {
    name                = "cmaz-wxu9jawu-mod5-asp-01"
    resource_group_name = "cmaz-wxu9jawu-mod5-rg-01"
    location            = "westeurope"
    sku_name            = "S1"
    os_type             = "Windows"
    instance_count      = 2
    tags                = {}
  }
  asp2 = {
    name                = "cmaz-wxu9jawu-mod5-asp-02"
    resource_group_name = "cmaz-wxu9jawu-mod5-rg-02"
    location            = "northeurope"
    sku_name            = "S1"
    os_type             = "Windows"
    instance_count      = 1
    tags                = {}
  }
}

# Windows Web Apps: APP1 on ASP1 in RG1, APP2 on ASP2 in RG2
app_service = {
  app1 = {
    name                 = "cmaz-wxu9jawu-mod5-app-01"
    resource_group_name  = "cmaz-wxu9jawu-mod5-rg-01"
    location             = "westeurope"
    app_service_plan_key = "asp1"
    tags                 = {}
  }
  app2 = {
    name                 = "cmaz-wxu9jawu-mod5-app-02"
    resource_group_name  = "cmaz-wxu9jawu-mod5-rg-02"
    location             = "northeurope"
    app_service_plan_key = "asp2"
    tags                 = {}
  }
}

# Access restriction: allow-ip and allow-tm (single list, CIDR for IP e.g. 18.153.146.156/32)
access_rules = [
  {
    name       = "allow-ip"
    priority   = 100
    ip_address = "18.153.146.156/32"
  },
  {
    name        = "allow-tm"
    priority    = 110
    service_tag = "AzureTrafficManager"
  }
]

# Verification agent IP address (also used in allow-ip rule above)
allowed_ip_address = "18.153.146.156"

# Traffic Manager: profile in rg3, routing method Performance
traffic_manager = {
  rg_key                 = "rg3"
  name                   = "cmaz-wxu9jawu-mod5-traf"
  relative_dns_name      = "cmaz-wxu9jawu-mod5-traf"
  traffic_routing_method = "Performance"
  ttl                    = 30
  protocol               = "HTTPS"
  port                   = 443
  path                   = "/"
  tags                   = {}
}
