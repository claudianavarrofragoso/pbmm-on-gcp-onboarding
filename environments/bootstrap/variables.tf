/**
 * Copyright 2021 Google LLC. This software is provided as is, without
 * warranty or representation for any use or purpose. Your use of it is
 * subject to your agreement with Google.
*/



variable "bootstrap" {
  description = "Object of values needed for bootstrapping method"
  type = object({
    userDefinedString           = string
    additionalUserDefinedString = string
    billingAccount              = string
    parent                      = string
    terraformDeploymentAccount  = string
    bootstrapEmail              = string
    region                      = string
    cloud_source_repo_name      = string
    projectServices             = list(string)

    tfstate_buckets = object({
      common = object(
        {
          name          = string
          labels        = optional(map(string)),
          storage_class = string
          force_destroy = bool
      })
      nonprod = object({
        name          = string
        labels        = optional(map(string)),
        storage_class = string
        force_destroy = bool
      })
      prod = object({
        name          = string
        labels        = optional(map(string)),
        storage_class = string
        force_destroy = bool
      })
    })
  })
}


variable "cloud_build_admins" {
  description = "List of IAM entities for Cloud Build Administrators"
  type        = list(string)
}

variable "group_build_viewers" {
  description = "List of IAM entities able to view Cloud Build output."
  type        = list(string)
}

variable "cloud_build_config" {
  description = "Object containing input values to configure Cloud Build."
  type = map(object({
    gcp_folder_suffix    = string
    workstream_path      = string
    included_files       = list(string)
    ignored_files        = list(string)
    pull_trigger_enabled = bool
    pull_gcbrun_enabled  = bool
    push_trigger_enabled = bool
  }))
}

variable "sa_impersonation_admin" {
  description = "IAM entity permitted to impersonate TF service accounts."
  type        = string
  default     = ""
}

variable "sa_impersonation_grants" {
  description = "List of IAM entities permitted to impersonate TF service accounts in specific folder/environment pairs."
  type = list(object({
    folder       = string
    env          = string
    impersonator = string
  }))
  default = [{
    env          = ""
    folder       = ""
    impersonator = ""
  }]
}

variable "sa_create_assign" {
  description = "List of service accounts to create and roles to assign to them"
  type = list(object({
    account_id   = string
    display_name = string
    roles        = list(string)
    project      = optional(string)
  }))
  default = []
}


variable "organization_config" {
  type = object({
    org_id          = string
    default_region  = string
    department_code = string
    owner           = string
    environment     = string
    location        = string
    labels          = object({})
    root_node       = string
    contacts        = object({})
    billing_account = string
  })
}
