variable "location" {
  description = <<-EOF
  The supported Azure location where the resource exists. 
  Changing this forces a new resource to be created.

EOF

  type    = string
  default = "West Europe"

}

variable "name" {
  description = <<-EOF
  Specifies the name of the Web App Bot. 
  Changing this forces a new resource to be created. Must be globally unique.

EOF

  type = string

}

variable "resource_group_name" {
  description = <<-EOF
  The name of the resource group in which to create the Web App Bot. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "sku_name" {
  description = <<-EOF
  The SKU of the Web App Bot. Valid values include `F0` or `S1`. 
  Changing this forces a new resource to be created.

EOF

  type    = string
  default = "F0"

}

variable "tags" {
  description = <<-EOF
    Tags to be added to resources created.
    
EOF

  type    = map(string)
  default = {}
}

variable "app_owners" {
  description = <<-EOF
    Add additional owners to the application registration,
    by defualt the caller is added.
    
EOF

  type    = string
  default = ""
}