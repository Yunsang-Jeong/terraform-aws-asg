resource "aws_autoscaling_group" "this" {
  name = join("-", compact(["asg", local.name_tag_middle, var.name]))

  # Placement
  availability_zones = var.availability_zones # EC2-Classic
  vpc_zone_identifier = var.vpc_zone_identifier # VPC - Subnet ids
  placement_group = var.placement_group

  # Capacity - General
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  # Capacity - ASG
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity

  # Capacity - ELB
  min_elb_capacity = var.min_elb_capacity
  wait_for_elb_capacity = var.wait_for_elb_capacity

  # Attach AWS ELB
  load_balancers = var.load_balancers # EC2-Classic
  target_group_arns = var.target_group_arns

  # Settings
  default_cooldown = var.default_cooldown
  force_delete = var.force_delete
  termination_policies = var.termination_policies
  suspended_processes = var.suspended_processes
  protect_from_scale_in = var.protect_from_scale_in

  capacity_rebalance = var.capacity_rebalance # False
  enabled_metrics = var.enabled_metrics
  service_linked_role_arn = var.service_linked_role_arn
  
  health_check_grace_period = var.health_check_grace_period
  health_check_type = var.health_check_type
  
  max_instance_lifetime = var.max_instance_lifetime
  metrics_granularity = var.metrics_granularity


  dynamic "initial_lifecycle_hook" {
    for_each = var.initial_lifecycle_hook
    content {
      name = initial_lifecycle_hook.value["name"]
      lifecycle_transition = initial_lifecycle_hook.value["lifecycle_transition"]
      default_result = initial_lifecycle_hook.value["default_result"]
      heartbeat_timeout = initial_lifecycle_hook.value["heartbeat_timeout"]
      notification_metadata = initial_lifecycle_hook.value["notification_metadata"]
      notification_target_arn = initial_lifecycle_hook.value["notification_target_arn"]
      role_arn = initial_lifecycle_hook.value["role_arn"]
    }
  }

  dynamic "instance_refresh" {
    for_each = var.instance_refresh == null ? toset([]) : toset([var.instance_refresh])
    content {
      strategy = instance_refresh.value["strategy"]
      triggers = instance_refresh.value["triggers"]

      dynamic "preferences" {
        for_each = instance_refresh.value.preferences
        content {
          instance_warmup = preferences.value["instance_warmup"]
          min_healthy_percentage = preferences.value["min_healthy_percentage"]
        }
      }

    }
  }

  ##################################################
  # Instance image
  launch_configuration = var.launch_configuration

  dynamic "launch_template" {
    for_each = var.launch_template == null ? toset([]) : toset([var.launch_template ])
    content {
      id = launch_template.value["id"]
      name = launch_template.value["name"]
      version = launch_template.value["version"]
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.mixed_instances_policy == null ? toset([]) : toset([var.mixed_instances_policy ])
    content {

      dynamic "instances_distribution" {
        for_each = mixed_instances_policy.value.instances_distribution == null ? toset([]) : mixed_instances_policy.value.instances_distribution
        content {
          on_demand_allocation_strategy = instances_distribution.value["on_demand_allocation_strategy"]
          on_demand_base_capacity = instances_distribution.value["on_demand_base_capacity"]
          on_demand_percentage_above_base_capacity = instances_distribution.value["on_demand_percentage_above_base_capacity"]
          spot_allocation_strategy = instances_distribution.value["spot_allocation_strategy"]
          spot_instance_pools = instances_distribution.value["spot_instance_pools"]
          spot_max_price = instances_distribution.value["spot_max_price"]
        }
      }

      dynamic "launch_template" {
        for_each = mixed_instances_policy.value.launch_template
        content {

          dynamic "launch_template_specification" {
            for_each = launch_template.value.launch_template_specification
            content {
              launch_template_id = launch_template_specification.value["launch_template_id"]
              launch_template_name = launch_template_specification.value["launch_template_name"]
              version = launch_template_specification.value["version"]
            }
          }

          dynamic "override" {
            for_each = launch_template.value.override
            content {
              instance_type = override.value["instance_type"]
              weighted_capacity = override.value["weighted_capacity"]

              dynamic "launch_template_specification" {
                for_each = override.value.launch_template_specification
                content {
                  launch_template_id = launch_template_specification.value["launch_template_id"]
                  launch_template_name = launch_template_specification.value["launch_template_name"]
                  version = launch_template_specification.value["version"]
                }
              }

            }
          }

        }
      }
    }
  }
  ##################################################

  ##################################################
  # All about tags : mutually exclusive
  tags = [
    for key, value in merge(var.additional_tag, {
      "Name" = join("-", compact(["asg", local.name_tag_middle, var.name]))
    }) : {
      "key": key,
      "value": value,
      "propagate_at_launch": true
    }
  ]

  dynamic "tag" {
    for_each = var.tag
    content {
      key = tag.value["key"]
      value = tag.value["value"]
      propagate_at_launch = tag.value["propagate_at_launch"]
    }
  }
  ##################################################

  dynamic "timeouts" {
    for_each = var.timeouts == null ? toset([]) : toset([var.timeouts])
    content {
      delete = timeouts.value["delete"]
    }
  }
}