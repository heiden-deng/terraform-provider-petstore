terraform {
  required_providers {
    petstore = {
      source  = "local-registry/heiden/petstore"
      version = "~> 1.0"
    }
  }
  backend "consul" {
    address = "127.0.0.1:8500"
    scheme = "http"
    path = "my-petstore-project"
  }
}

provider "petstore" {
  address = "http://localhost:8000"
}


variable "new_pet" {
  type=object({
    name=string
    species=string
    age=number
  })
}


data "petstore_pet" "old_pet"{
  id = "74b45a25-2dee-4a79-b42b-9b039f860279"
  #most_recent = true
}

resource "petstore_pet" "my_pet" {
  name    = var.new_pet.name
  species = var.new_pet.species
  age     = var.new_pet.age + data.petstore_pet.old_pet.age
}

output "petstore_id" {
  value= petstore_pet.my_pet.id
  description = "The id of the pet"
}




/*在命令行中隐藏敏感信息
variable "user_information" {
  type = object({
    name    = string
    address = string
  })
  sensitive = true
}

resource "some_resource" "a" {
  name    = var.user_information.name
  address = var.user_information.address
}
*/

/* 创建重复对象
resource "aws_instance" "server" {
  count = 4 # create four similar EC2 instances

  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"

  tags = {
    Name = "Server ${count.index}"
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = {
    a_group = "eastus"
    another_group = "westus2"
  }
  name     = each.key
  location = each.value
}

resource "aws_iam_user" "the-accounts" {
  for_each = toset( ["Todd", "James", "Alice", "Dottie"] )
  name     = each.key
}

控制生命周期
resource "azurerm_resource_group" "example" {
  # ...

  lifecycle {
    create_before_destroy = true  #创建成功后才删除旧的
  }
}

#创建前后检查
data "aws_ami" "example" {
  id = var.aws_ami_id

  lifecycle {
    # The AMI ID must refer to an existing AMI that has the tag "nomad-server".
    postcondition {   #precondition
      condition     = self.tags["Component"] == "nomad-server"
      error_message = "tags[\"Component\"] must be \"nomad-server\"."
    }
  }
}

#资源创建后执行指定动作，如下，通过ssh拷贝本地文件导入新建资源目标目录下
resource "aws_instance" "web" {
  # ...

  provisioner "file" {
  source       = "conf/myapp.conf"
  destination  = "/etc/myapp.conf"

    connection {
      type     = "ssh"
      user     = "root"
      password = var.root_password
      host     = self.public_ip
    }
  }
}

resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command    = "echo The server's IP address is ${self.private_ip}"
    on_failure = continue
  }
}
*/
