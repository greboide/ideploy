# -*- coding: utf-8 -*-

Dado /^que eu terminei de codar uma feature$/ do
end

Dado /^o projeto está configurado para deploy$/ do
   %x(thor ideploy:check_ssh_connection).should == ""
end

Quando /^eu atualizar o repo localmente$/ do
  %x(thor ideploy:update_repo_with_git).should =~ /true/
end

Quando /^atualizar o repositório no servidor$/ do
    %x(thor ideploy:update_server_from_repo).should =~ /forward/
end

Quando /^re\-atualizar o servidor web$/ do
  %x(thor ideploy:reload_http_server).should =~ /Gracefully/
  # substitute the above regexp with a message from your http server when reloading
end

Dado /^que eu iniciei um novo projeto$/ do
end

Dado /^tenho acesso via chaves ssh ao servidor web$/ do
  %x(thor ideploy:check_ssh_connection).should == ""
end

Quando /^preencho o "([^"]*)" em config\/deploy\.yml$/ do |arg1|
  %x(thor ideploy:check_config).should == ""
end


Então /^eu devo ter o projeto configurado$/ do
end

Então /^eu devo ter meu deployment realizado$/ do
end
