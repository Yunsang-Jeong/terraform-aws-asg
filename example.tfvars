subnet_ids = [
  lookup(dependency.vpc.outputs.subnet_ids, "private-web-a"),
  # lookup(dependency.vpc.outputs.subnet_ids, "private-web-c"),
]
target_group_identifiers = ["360srv-web"]
suspended_processes = ["ReplaceUnhealthy", "Terminate"]
min_size = 1
max_size = 1
desired_capacity = 1