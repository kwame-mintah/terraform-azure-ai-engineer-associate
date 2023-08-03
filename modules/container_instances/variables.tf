variable "environment" {
  description = <<-EOF
  The name of the _environment_ to help identify resources.

EOF

  type = string
}

variable "cognitive_service_endpoint" {
  description = <<-EOF
  The endpoint URI for your cognitive services resource.

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
  Specifies the name of the Container Group. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "image" {
  description = <<-EOF
  The container image name. 
  Changing this forces a new resource to be created.

EOF

  type = string

}

variable "cognitive_service_api_key" {
  description = <<-EOF
  Either key for your cognitive services resource.

EOF

  type = string

}

variable "resource_group_name" {
  description = <<-EOF
  The name of the resource group in which the Cognitive Service Account is created. 
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
