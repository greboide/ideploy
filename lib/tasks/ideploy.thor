require 'yaml'
class Ideploy < Thor
  include Thor::Actions
  def initialize(*args)
    super
    check_config
  end

  desc "check_config", "check if you have configured ideploy correctly"
  def check_config
    open_config
    if @@iconfig.each { |key, assc| assc != nil} then "" else "you need to configure your paths"
    end
  end
  desc "check_ssh_connection", "check if you can login on server to deploy"
  def check_ssh_connection
    a = %x{ ssh -q -o "BatchMode=yes" #{ @@iconfig['user']}@#{ @@iconfig['server']} "echo 2>&1" && echo 1 || echo 0}
    if a.to_i == 1
    else
      puts "you need to setup your ssh keys, checkout keychain its cool"
    end
  end
  desc "update_repo_with_git", "wrapper around git to commit and push, just a convenience, not intended to be used(read: for lazy)"
  def update_repo_with_git
    %x( git commit -a)
    a = run('git push')
    puts a
  end
  desc "update_server_from_repo", "updates deployed sources"
  def update_server_from_repo
    check_config
    a = %x{ ssh -q -o "BatchMode=yes" #{ @@iconfig['user']}@#{ @@iconfig['server']} "cd #{@@iconfig['path']} && git pull"}
    puts a
    return a
  end
  desc "reload_http_server", "reload http server configs so we can be live updated"
  def reload_http_server
    a = %x{ ssh -q -o "BatchMode=yes" #{ @@iconfig['user']}@#{ @@iconfig['server']} "/etc/init.d/apache2 reload"}
    puts a
    return a
  end
  desc "deploy", "call all deployment steps and deploys for you"
  def deploy
    check_config
    check_ssh_connection
    update_repo_with_git
    update_server_from_repo
    reload_http_server
    puts "Your deployment was successfull, if not try running the steps individually and check where the error is."
  end

  private
  def open_config
    @@iconfig = open('config/deploy.yml') {|f| YAML.load(f) }
  end

end
