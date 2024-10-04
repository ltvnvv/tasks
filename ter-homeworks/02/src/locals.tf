locals {
    env = "develop"
    project = "platform"
    name_web = "netology-${ local.env }-${ local.project }-web"
    name_db = "netology-${ local.env }-${ local.project }-db"
}