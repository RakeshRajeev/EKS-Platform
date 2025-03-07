resource "aws_launch_template" "eks_nodes" {
  name                   = "${var.cluster_name}-launch-template"
  image_id               = var.ami_id          # Your custom AMI ID
  instance_type          = "t3.medium"
  key_name               = var.ssh_key_name    # SSH key for node access
  vpc_security_group_ids = [var.node_security_group_id]  # Security group for nodes

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-worker-node"
    }
  }
}