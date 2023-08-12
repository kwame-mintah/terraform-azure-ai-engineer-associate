variable "environment" {
  description = <<-EOF
  The name of the _environment_ to help identify resources.

EOF

  type = string
}

variable "location" {
  description = <<-EOF
  Specifies the supported Azure location where the resource exists. 
  Changing this forces a new resource to be created.

EOF

  type    = string
  default = "West Europe"

}

variable "name" {
  description = <<-EOF
  Specifies the name of the Media Services Account. 
  Only lowercase Alphanumeric characters allowed. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "resource_group_name" {
  description = <<-EOF
  The name of the resource group in which to create the Media Services Account. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "tags" {
  description = <<-EOF
    Tags to be added to resources created.
    
EOF

  type    = map(string)
  default = {}
}

variable "personal_ip_address" {
  description = <<-EOF
    Add your client IP address to the networking to allow
    access.
    
EOF

  type = string
}
