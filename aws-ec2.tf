data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "app_a_instance" {
  ami                         = data.aws_ami.this.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_a_instance_profile.name

  tags = {
    Name = "${var.app_a_prefix}-instance"
  }

  user_data = templatefile("${path.module}/script/userdata.tftpl", {
    vault_addr      = var.vault_addr,
    vault_namespace = var.vault_namespace
    secret_path     = "${vault_mount.pki.path}/issue/${vault_pki_secret_backend_role.role.name}"
    common_name     = "demo.${var.common_name}"
    role_name       = aws_iam_role.app_a_role.name
  })
}

resource "aws_instance" "app_b_instance" {
  ami                         = data.aws_ami.this.id
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = aws_subnet.public_subnets[0].id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.app_b_instance_profile.name

  tags = {
    Name = "${var.app_b_prefix}-instance"
  }

  user_data = templatefile("${path.module}/script/userdata.tftpl", {
    vault_addr      = var.vault_addr,
    vault_namespace = var.vault_namespace,
    secret_path     = "${vault_mount.pki.path}/issue/${vault_pki_secret_backend_role.role.name}"
    common_name     = "demo.${var.common_name}"
    role_name       = aws_iam_role.app_a_role.name
  })
}
