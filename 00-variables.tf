##################################################
# Shared
variable "name_tag_convention" {
  description = "Name tag convention"
  type = object({
    project_name   = string
    stage          = string
  })
}

variable "additional_tag" {
  description = "Additional tags for all resources created within a Terraform, e.g. Enviroment, System"
  type        = map(string)
  default     = {}
}
##################################################

##################################################
# ASG location
variable "availability_zones" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "vpc_zone_identifier" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "capacity_rebalance" {
  description = "(optional)"
  type        = bool
  default     = false
}

variable "default_cooldown" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "enabled_metrics" {
  description = "(optional)"
  type        = set(string)
  default     = null
  # GroupDesiredCapacity, GroupInServiceCapacity, GroupPendingCapacity, 
  # GroupMinSize, GroupMaxSize, GroupInServiceInstances, GroupPendingInstances, 
  # GroupStandbyInstances, GroupStandbyCapacity, GroupTerminatingCapacity, 
  # GroupTerminatingInstances, GroupTotalCapacity, GroupTotalInstances
}

variable "force_delete" {
  description = "(optional)"
  type        = bool
  default     = null
}

variable "health_check_grace_period" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "health_check_type" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "launch_configuration" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "load_balancers" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "max_instance_lifetime" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "max_size" {
  description = "(required)"
  type        = number
}

variable "metrics_granularity" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "min_elb_capacity" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "min_size" {
  description = "(required)"
  type        = number
}

variable "name" {
  description = "(optional)"
  type        = string
}

variable "placement_group" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "protect_from_scale_in" {
  description = "(optional)"
  type        = bool
  default     = null
}

variable "service_linked_role_arn" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "suspended_processes" {
  description = "(optional)"
  type        = set(string)
  default     = null
  # Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, 
  # AlarmNotification, ScheduledActions, AddToLoadBalancer
}

variable "tags" {
  description = "(optional)"
  type        = set(map(string))
  default     = null
}

variable "target_group_arns" {
  description = "(optional)"
  type        = set(string)
  default     = null
}

variable "termination_policies" {
  description = "(optional)"
  type        = list(string)
  default     = null
  # OldestInstance, NewestInstance, OldestLaunchConfiguration, 
  # ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, 
  # Default
}

variable "wait_for_capacity_timeout" {
  description = "(optional)"
  type        = string
  default     = null
}

variable "wait_for_elb_capacity" {
  description = "(optional)"
  type        = number
  default     = null
}

variable "initial_lifecycle_hook" {
  description = "nested block: NestingSet, min items: 0, max items: 0"
  type = set(object(
    {
      name                    = string
      lifecycle_transition    = string
      default_result          = optional(string)
      heartbeat_timeout       = optional(number)
      notification_metadata   = optional(string)
      notification_target_arn = optional(string)
      role_arn                = optional(string)
    }
  ))
  default = []
}

variable "instance_refresh" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = object(
    {
      strategy = string
      triggers = optional(set(string))
      preferences = optional(list(object(
        {
          instance_warmup        = optional(string)
          min_healthy_percentage = optional(number)
        }
      )))
    }
  )
  default = null
}

variable "launch_template" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = object(
    {
      id      = optional(string)
      name    = optional(string)
      version = optional(string) # $Latest or $Default
    }
  )
  default = null
}

variable "mixed_instances_policy" {
  description = "nested block: NestingList, min items: 0, max items: 1"
  type = object(
    {
      launch_template = list(object(
        {
          launch_template_specification = list(object(
            {
              launch_template_id   = optional(string)
              launch_template_name = optional(string)
              version              = optional(string)
            }
          ))
          override = optional(list(object(
            {
              instance_type = optional(string)
              launch_template_specification = optional(list(object(
                {
                  launch_template_id   = optional(string)
                  launch_template_name = optional(string)
                  version              = optional(string)
                }
              )))
              weighted_capacity = optional(string)
            }
          )))
        }
      ))
      instances_distribution = optional(list(object(
        {
          on_demand_allocation_strategy            = optional(string)
          on_demand_base_capacity                  = optional(number)
          on_demand_percentage_above_base_capacity = optional(number)
          spot_allocation_strategy                 = optional(string)
          spot_instance_pools                      = optional(number)
          spot_max_price                           = optional(string)
        }
      )))
    }
  )
  default = null
}

variable "tag" {
  description = "nested block: NestingSet, min items: 0, max items: 0"
  type = set(object(
    {
      key                 = string
      propagate_at_launch = bool
      value               = string
    }
  ))
  default = []
}

variable "timeouts" {
  description = "nested block: NestingSingle, min items: 0, max items: 0"
  type = object(
    {
      delete = string
    }
  )
  default = null
}
##################################################