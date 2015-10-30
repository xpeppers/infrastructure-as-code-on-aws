CloudFormation {
  Description "#{name} blog stack"

  EC2_SecurityGroup(:WebSecurityGroup) {
    VpcId vpc_id
    GroupDescription "Allow web traffic"

    SecurityGroupIngress {
      IpProtocol "tcp"
      FromPort 80
      ToPort 80
      CidrIp "0.0.0.0/0"
    }
  }

  EC2_Instance(:WordpressInstance) {
    ImageId ami
    KeyName key_name
    SecurityGroupIds [Ref(:WebSecurityGroup)]
    InstanceType "t2.small"
    SubnetId subnet_id
    addTag("Name", "#{name}-blog")
  }

  Output(:IP, FnGetAtt(:WordpressInstance, 'PublicIp'))
}
