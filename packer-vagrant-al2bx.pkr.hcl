packer {
  required_plugins {
    vagrant = {
      version = ">= 1.0.0"
      source = "github.com/hashicorp/vagrant"
    }
    chef = {
      source  = "github.com/hashicorp/chef"
      version = ">=1.0.0"
    }
  }
}

source "vagrant" "example" {
  communicator    = "ssh"
  output_dir      = "amazonlinux-2box"
  provider        = "virtualbox"
  skip_add        = true
  source_path     = "bento/amazonlinux-2"
 #source_path     = "hashicorp/precise64"
}

build {
  sources = ["source.vagrant.example"]

  provisioner "chef-solo" {
    cookbook_paths = ["./cookbooks"]
    run_list       = [
      "recipe[aws_ssm_plugin::default]",
      "recipe[cloudwatch_agent::default]",
      "recipe[postgres_db::default]"
    ]
  }
 
  post-processor "vagrant" {
    output = "./amazonlnux-2box/al2chef.box"
  }

}
