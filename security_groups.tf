#---------------------|
#---SECURITY GROUPS---|
#---------------------|
resource "aws_security_group" "alb_sg" {
  name   = "${local.NAME_PREFIX_DEV}-alb-sg"
  description = "Security group for ALB."
  vpc_id = aws_vpc.vpc.id

# Inbound rules: Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules: Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = merge(local.COMMON_TAGS, {
    Name = "${local.NAME_PREFIX_DEV}-alb-sg"
  })

}

resource "aws_security_group" "eks_cluster_sg" {
  name        = "${local.NAME_PREFIX_DEV}-eks-cluster-sg"
  description = "Security group for EKS cluster control plane communication with worker nodes."
  vpc_id      = aws_vpc.vpc.id

  # Inbound rules: Allow incoming traffic on port 443 for HTTPS (Kubernetes API server)
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = merge(local.COMMON_TAGS, {
    Name = "${local.NAME_PREFIX_DEV}-eks-cluster-sg"
  })
}