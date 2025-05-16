resource "render_web_service" "bigagi" {
  name    = "bigagi"
  plan    = "starter"
  region  = "oregon"
  start_command = "npm start"

  runtime_source {
    native_runtime {
      auto_deploy   = true
      branch        = "main"
      build_command = "npm install"
      repo_url      = "https://github.com/enricoros/big-AGI"
      runtime       = "node"
    }
  }
}
