variable "environment" {
  description = <<-EOF
  The name of the _environment_ to help identify resources.

EOF

  type = string
}

variable "location" {
  description = <<-EOF
  Specifies the supported Azure location where the Machine Learning Workspace should exist. 
  Changing this forces a new resource to be created.

EOF

  type    = string
  default = "West Europe"

}

variable "name" {
  description = <<-EOF
  Specifies the name of the Machine Learning Workspace. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "resource_group_name" {
  description = <<-EOF
  Specifies the name of the Resource Group in which the Machine Learning Workspace should exist. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "personal_ip_address" {
  description = <<-EOF
    Add your client IP address to the networking to allow
    access.
    
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
