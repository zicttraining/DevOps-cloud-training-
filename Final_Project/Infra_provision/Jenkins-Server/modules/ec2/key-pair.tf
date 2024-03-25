resource "aws_key_pair" "jenkins-key" {
  key_name   = "jenkins-${var.env}"
  public_key = "${file("${path.root}/modules/ec2/keyfiles/id_rsa.pub")}"
}
