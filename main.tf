terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "3.0.2"
    }
  }
}

provider "docker" {}

# Create a private network for containers to communicate

resource "docker_network" "wordpress_network" {
    name = "wordpress_net"
    driver = "bridge"
}

# MySQL Database Image
resource "docker_image" "mysql" {
  name = "mysql:8.0"
  keep_locally = true
}

#MySQL Database Container
resource "docker_container" "mysql_db" {
  name = "mysql_db"
  image = docker_image.mysql.name
  env = [
"MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${var.mysql_password}",
    "MYSQL_TCP_PORT=3306",
  ]

  networks_advanced {
    name = docker_network.wordpress_network.name
  }

  volumes {
    container_path = "/var/lib/mysql"
    host_path = "C:/mysql_data"
  }

  restart = "unless-stopped"
} 

#Wordpress section

resource "docker_image" "wordpress" {
  name = "wordpress:latest"
}

resource "docker_container" "wordpress_app" {
  name = "wordpress_app"
  image = docker_image.wordpress.name

  env = [
    "WORDPRESS_DB_HOST=mysql_db:3306",
    "WORDPRESS_DB_USER=wordpress",

    "WORDPRESS_DB_PASSWORD=${var.mysql_password}",
    "WORDPRESS_DB_NAME=wordpress"
]

  networks_advanced {
    name =docker_network.wordpress_network.name
  }

   ports {
    internal = 80
    external = 8081
   }

   depends_on = [docker_container.mysql_db]

   restart = "unless-stopped"
}

# phpMyAdmin - Database Management Interface
resource "docker_image" "phpmyadmin" {
  name = "phpmyadmin/phpmyadmin:latest"
  keep_locally = true
}

resource "docker_container" "phpmyadmin" {
    name = "phpmyadmin"
    image = docker_image.phpmyadmin.name

    #Tell phpmyadmin where mysql is
    env = [
         "PMA_HOST=mysql_db",
         "PMA_PORT=3306"
    ]

    #Connect to our private network
    networks_advanced {
      name = docker_network.wordpress_network.name
    }

    #Map port so you can access it from browser
    ports {
      internal = 80
      external = 8082
    }

    #Wait for MySQL to be ready first
    depends_on = [ docker_container.mysql_db ]

    restart = "unless-stopped"
}