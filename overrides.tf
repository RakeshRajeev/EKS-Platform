resource "aws_iam_role" "eks_override" {
  for_each = toset(module.eks.this_iam_role_name)
  name = each.value
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_policy" "eks_override" {
  for_each = toset(module.eks.this_iam_role_name)
  name   = "${each.value}-eks-policy"
  policy = var.inline_policy
}

resource "aws_iam_role_policy_attachment" "eks_override" {
  for_each = toset(module.eks.this_iam_role_name)
  role       = each.value
  policy_arn = aws_iam_policy.eks_override[each.key].arn
}

resource "aws_iam_role_policy" "eks_override" {
  for_each = toset(module.eks.this_iam_role_name)
  role     = aws_iam_role.eks_override[each.key].name
  policy   = var.inline_policy
}
