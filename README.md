# Overview

AWS Autoscaling group을 생성하는 모듈입니다. 하단의 내용은 `terraform-docs`에 의해 생성되었습니다.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.35.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.35.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag"></a> [additional\_tag](#input\_additional\_tag) | Additional tags for all resources. | `map(string)` | `{}` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (optional) | `set(string)` | `null` | no |
| <a name="input_capacity_rebalance"></a> [capacity\_rebalance](#input\_capacity\_rebalance) | (optional) | `bool` | `false` | no |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | (optional) | `number` | `null` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | (optional) | `number` | `null` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | (optional) | `set(string)` | `[]` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | (optional) | `bool` | `false` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | (optional) | `number` | `null` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | (optional) | `string` | `null` | no |
| <a name="input_initial_lifecycle_hook"></a> [initial\_lifecycle\_hook](#input\_initial\_lifecycle\_hook) | nested block: NestingSet, min items: 0, max items: 0 | <pre>set(object(<br>    {<br>      name                    = string<br>      lifecycle_transition    = string<br>      default_result          = optional(string)<br>      heartbeat_timeout       = optional(number)<br>      notification_metadata   = optional(string)<br>      notification_target_arn = optional(string)<br>      role_arn                = optional(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_instance_refresh"></a> [instance\_refresh](#input\_instance\_refresh) | nested block: NestingList, min items: 0, max items: 1 | <pre>object(<br>    {<br>      strategy = string<br>      triggers = optional(set(string))<br>      preferences = optional(list(object(<br>        {<br>          instance_warmup        = optional(string)<br>          min_healthy_percentage = optional(number)<br>        }<br>      )))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_launch_configuration"></a> [launch\_configuration](#input\_launch\_configuration) | (optional) | `string` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | nested block: NestingList, min items: 0, max items: 1 | <pre>object(<br>    {<br>      id      = optional(string)<br>      name    = optional(string)<br>      version = optional(string) # $Latest or $Default<br>    }<br>  )</pre> | `null` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | (optional) For EC2-class | `set(string)` | `[]` | no |
| <a name="input_max_instance_lifetime"></a> [max\_instance\_lifetime](#input\_max\_instance\_lifetime) | (optional) | `number` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | (required) | `number` | n/a | yes |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | (optional) | `string` | `null` | no |
| <a name="input_min_elb_capacity"></a> [min\_elb\_capacity](#input\_min\_elb\_capacity) | (optional) | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | (required) | `number` | n/a | yes |
| <a name="input_mixed_instances_policy"></a> [mixed\_instances\_policy](#input\_mixed\_instances\_policy) | nested block: NestingList, min items: 0, max items: 1 | <pre>object(<br>    {<br>      launch_template = list(object(<br>        {<br>          launch_template_specification = list(object(<br>            {<br>              launch_template_id   = optional(string)<br>              launch_template_name = optional(string)<br>              version              = optional(string)<br>            }<br>          ))<br>          override = optional(list(object(<br>            {<br>              instance_type = optional(string)<br>              launch_template_specification = optional(list(object(<br>                {<br>                  launch_template_id   = optional(string)<br>                  launch_template_name = optional(string)<br>                  version              = optional(string)<br>                }<br>              )))<br>              weighted_capacity = optional(string)<br>            }<br>          )))<br>        }<br>      ))<br>      instances_distribution = optional(list(object(<br>        {<br>          on_demand_allocation_strategy            = optional(string)<br>          on_demand_base_capacity                  = optional(number)<br>          on_demand_percentage_above_base_capacity = optional(number)<br>          spot_allocation_strategy                 = optional(string)<br>          spot_instance_pools                      = optional(number)<br>          spot_max_price                           = optional(string)<br>        }<br>      )))<br>    }<br>  )</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (optional) | `string` | n/a | yes |
| <a name="input_name_tag_convention"></a> [name\_tag\_convention](#input\_name\_tag\_convention) | The name tag convention of all resources. | <pre>object({<br>    project_name   = string<br>    stage          = string<br>  })</pre> | <pre>{<br>  "project_name": "tf",<br>  "stage": "poc"<br>}</pre> | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | (optional) | `string` | `null` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | (optional) | `bool` | `null` | no |
| <a name="input_service_linked_role_arn"></a> [service\_linked\_role\_arn](#input\_service\_linked\_role\_arn) | (optional) | `string` | `null` | no |
| <a name="input_suspended_processes"></a> [suspended\_processes](#input\_suspended\_processes) | (optional) | `set(string)` | `[]` | no |
| <a name="input_tag"></a> [tag](#input\_tag) | nested block: NestingSet, min items: 0, max items: 0 | <pre>set(object(<br>    {<br>      key                 = string<br>      propagate_at_launch = bool<br>      value               = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (optional) | `set(map(string))` | `null` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | (optional) | `set(string)` | `null` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | (optional) | `list(string)` | `[]` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | nested block: NestingSingle, min items: 0, max items: 0 | <pre>object(<br>    {<br>      delete = string<br>    }<br>  )</pre> | `null` | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | (optional) | `set(string)` | `null` | no |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | (optional) | `string` | `null` | no |
| <a name="input_wait_for_elb_capacity"></a> [wait\_for\_elb\_capacity](#input\_wait\_for\_elb\_capacity) | (optional) | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | returns a string |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | returns a set of string |
| <a name="output_default_cooldown"></a> [default\_cooldown](#output\_default\_cooldown) | returns a number |
| <a name="output_desired_capacity"></a> [desired\_capacity](#output\_desired\_capacity) | returns a number |
| <a name="output_health_check_type"></a> [health\_check\_type](#output\_health\_check\_type) | returns a string |
| <a name="output_id"></a> [id](#output\_id) | returns a string |
| <a name="output_name"></a> [name](#output\_name) | returns a string |
| <a name="output_service_linked_role_arn"></a> [service\_linked\_role\_arn](#output\_service\_linked\_role\_arn) | returns a string |
| <a name="output_this"></a> [this](#output\_this) | n/a |
| <a name="output_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#output\_vpc\_zone\_identifier) | returns a set of string |

## Example
```hcl
subnet_ids = [
  lookup(dependency.vpc.outputs.subnet_ids, "private-web-a"),
  # lookup(dependency.vpc.outputs.subnet_ids, "private-web-c"),
]
target_group_identifiers = ["360srv-web"]
suspended_processes = ["ReplaceUnhealthy", "Terminate"]
min_size = 1
max_size = 1
desired_capacity = 1
```
<!-- END_TF_DOCS -->