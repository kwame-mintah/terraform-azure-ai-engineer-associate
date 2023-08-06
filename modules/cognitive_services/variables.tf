variable "kind" {
  description = <<-EOF
  Specifies the type of Cognitive Service Account that should be created. 
  Possible values are `Academic`, `AnomalyDetector`, `Bing.Autosuggest`, 
  `Bing.Autosuggest.v7`, `Bing.CustomSearch`, `Bing.Search`, `Bing.Search.v7`, 
  `Bing.Speech`, `Bing.SpellCheck`, `Bing.SpellCheck.v7`, `CognitiveServices`, 
  `ComputerVision`, `ContentModerator`, `CustomSpeech`, `CustomVision.Prediction`, 
  `CustomVision.Training`, `Emotion`, `Face`, `FormRecognizer`, `ImmersiveReader`, 
  `LUIS`, `LUIS.Authoring`, `MetricsAdvisor`, `OpenAI`, `Personalizer`, `QnAMaker`, 
  `Recommendations`, `SpeakerRecognition`, `Speech`, `SpeechServices`, `SpeechTranslation`, 
  `TextAnalytics`, `TextTranslation` and `WebLM`. 
  Changing this forces a new resource to be created.

EOF

  type    = string
  default = "CognitiveServices"

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
  Specifies the name of the Cognitive Service Account. 
  Changing this forces a new resource to be created.

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

variable "sku_name" {
  description = <<-EOF
  Specifies the SKU Name for this Cognitive Service Account. 
  Possible values are `F0`, `F1`, `S0`, `S`, `S1`, `S2`, `S3`, 
  `S4`, `S5`, `S6`, `P0`, `P1`, `P2`, `E0` and `DC0`

EOF

  type    = string
  default = "S0"

}

variable "search_service_id" {
  description = <<-EOF
  If kind is `TextAnalytics` this specifies the ID of the Search service.

EOF

  type    = string
  default = null

}

variable "search_service_key" {
  description = <<-EOF
  If kind is `TextAnalytics` this specifies the key of the Search service.

EOF

  type    = string
  default = null

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
