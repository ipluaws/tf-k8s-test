output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks.arn
}

