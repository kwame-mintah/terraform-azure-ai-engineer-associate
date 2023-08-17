variable "location" {
  description = <<-EOF
  The Azure Region where the Linux Function App should exist. 
  Changing this forces a new Linux Function App to be created.

EOF

  type    = string
  default = "West Europe"

}

variable "name" {
  description = <<-EOF
  The name which should be used for this Linux Function App. 
  Changing this forces a new Linux Function App to be created. 
  Limit the function name to 32 characters to avoid naming collisions. 

EOF

  type = string

}

variable "resource_group_name" {
  description = <<-EOF
  The name of the Resource Group where the Linux Function App should exist. 
  Changing this forces a new Linux Function App to be created.

EOF

  type = string

}

variable "service_plan" {
  description = <<-EOF
  The pricing tier for hosting the resource.

EOF

  type    = string
  default = "Y1"
}

variable "storage_account_name" {
  description = <<-EOF
  The backend storage account name which will be used by this Function App.

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
