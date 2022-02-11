module "instance_profile_label" {
  source     = "cloudposse/label/null"
  version    = "0.22.1"
  attributes = distinct(compact(concat(module.this.attributes, ["profile"])))
  context    = module.this.context
}

resource "aws_iam_role" "role" {
  name = module.instance_profile_label.id
  tags = module.instance_profile_label.tags
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_instance_profile" "profile" {
  name = module.instance_profile_label.id
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "policy" {
  name = module.instance_profile_label.id
  role = aws_iam_role.role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:GetParameter"
          ],
          "Resource" : "arn:aws:ssm:${local.region}:${local.account_id}:parameter/${local.consul_ssm_param}"
        }
      ]
    }
  )
}
