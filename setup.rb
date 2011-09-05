#!/usr/bin/env ruby
# encoding: UTF-8

puts "*******************************************************************************************"
puts "Este script de configuracion eliminara la configuracion que haya hecho en el archivo de\
      configuracion de la base de datos."
puts "Si quiere cancelar estas operaciones, presione <Ctrl-c> para salir."
puts "*******************************************************************************************"
puts

puts
puts "Antes de iniciar este script, asegurese estar utilizando ruby 1.9.2, de tener instalado rubygems, bundler y de haber ejecutado \'bundle install\'"
puts "Comprobando versiones de ruby, rails y rubygems:"
puts
puts "Ruby version: (>= 1.9.2)"
system("ruby -v")
puts "Rubygems version: (>= 1.3.7)"
system("gem -v")
puts 
puts "Continuar?['n' o 'y']"
response = gets
response = 'n' if response == '\n'

if !response.include?('y') || response.include?('Y')
  exit
end

puts "Instalndo las librerias necesarias:"
puts "Espere por favor..."
if system("gem install bundler")
  if system("bundle install")
    puts "terminado"
  else
    exit
  end
else
  exit
end

puts "Configuracion de la base de datos:"
print "Ingrese el NOMBRE de la base de datos (MySQL) [conservar]: "
db = gets
db = "conservar" if db == "\n"
print "Ingrese el USUARIO para la base de datos (MySQL) [conservar]: "
dbuser = gets
dbuser = "conservar" if dbuser == "\n"
print "Ingrese la PASSWORD para la base de datos (MySQL) [cambiar]: "
dbpw = gets
dbpw = "cambiar" if dbpw == "\n"
print "Ingrese el HOST para la base de datos (MySQL) [localhost]: "
dbhost = gets
dbhost = "localhost" if dbhost == "\n"

db.strip!
dbuser.strip!
dbpw.strip!
dbhost.strip!

puts
puts "Utilizando '#{dbuser}' / '#{dbpw}' para acceder a la base de datos '#{db}' en '#{dbhost}'."
puts



puts "Si no creo la base de datos, tiene que hacerlo antes de continuar: "
puts "\"mysql -u root -p\" y despues:\n \"CREATE DATABASE #{db} DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci; GRANT ALL ON #{db}.* TO '#{dbuser}'@'localhost' IDENTIFIED BY '#{dbpw}'; FLUSH PRIVILEGES;\""
puts
puts "Presione <enter> una vez que la base este creada."
gets
puts

domain = "\n"
while domain == "\n" || domain.split('.').size < 3
  puts
  print "Ingrese el hostname para la aplicacion (ejemplo: conservar.mi_sitio.com): "
  domain = gets
end

domain.strip!

subdomain = domain.split('.').first
domain = domain.split('.')[1..-1].join('.')

puts
puts "Utilizaremos '#{subdomain}.#{domain}' como hostname para la aplicacion."
puts

puts "Configuracion del usuario administrador "
name = "\n"
while name == "\n"
  print "Ingrese el NOMBRE: "
  name = gets
end

username = "\n"
while username == "\n"
  print "Ingrese el USUARIO: "
  username = gets
end

password = "\n"
password2 = "\n"

while password != password2 || password == "\n"

  password = "\n"
  password2 = "\n"

  while password == "\n"
    print "Ingrese el PASSWORD: "
    password = gets
  end

  while password2 == "\n"
    print "Ingrese el PASSWORD de nuevo por favor: "
    password2 = gets
  end

  password.strip!
  password2.strip!
end

email = "\n"
while email == "\n"
print "Ingrese el EMAIL: "
  email = gets
end

name.strip!
username.strip!
password.strip!
email.strip!

puts
puts "Se creara el usuario: '#{username}' con el password '#{password}' como administrador."
puts


puts "Creando config/database.yml"

db_config = []
File.open("config/database.yml-example") do |file|
  while line = file.gets
    db_config << line
  end
end
db_config = db_config.join

db_config.gsub!(/DATABASE/, db)
db_config.gsub!(/USERNAME/, dbuser)
db_config.gsub!(/PASSWORD/, dbpw)
db_config.gsub!(/HOST/, dbhost)

File.open("config/database.yml", "w") do |file|
  file.puts db_config
end

#puts "Creating config/environment.local.rb"

#env = []
#File.open("config/environment.local.example") do |file|
#  while line = file.gets
#    env << line
#  end
#end
#env = env.join
#
#env.gsub!(/getjobsworth\.org/, domain)
#
#File.open("config/environment.local.rb", "w") do |file|
#  file.puts env
#end
#
#puts "Creating directories..."
#
#puts "  log..."
#Dir.mkdir("log") rescue nil
#puts "  index..."
#Dir.mkdir("index") rescue nil
#puts "  store..."
#Dir.mkdir("store") rescue nil
#puts "  store/avatars..."
#Dir.mkdir("store/avatars") rescue nil
#puts "  store/logos..."
#Dir.mkdir("store/logos") rescue nil
#puts "  tmp..."
#Dir.mkdir("tmp") rescue nil
#puts "  tmp/cache..."
#Dir.mkdir("tmp/cache") rescue nil

puts
print "Cargar el schema de la base de datos? [y]: "
init_db = gets
init_db = "y" if init_db == "\n"

if init_db.include?('y') || init_db.include?('Y')
  puts "Creando las tablas en la base de datos..."
  system("rake db:schema:load RAILS_ENV=production")
  system("rake db:migrate RAILS_ENV=production")
end

puts
puts "Cargando Rails para crear la cuenta del administrador..."
begin
  require File.expand_path('../config/environment', __FILE__)
rescue
  puts "*** Error al cargar Rails, asegurese que esta funcionando el entorno de rails. ***"
  exit
end

puts
begin
  @user = User.new
  puts "  Creando usuario..."
  @user.name = name
  @user.lastname = name
  @user.username = username
  @user.password = password
  @user.password_confirmation = password
  @user.role = 'admin'
  @user.email = email
  @user.save
rescue 
  puts "No fue posible crear el usuario, intentelo despues."
end
puts
puts "Realizando las migraciones pendientes..."
system("rake db:migrate RAILS_ENV=production")

puts
puts "Terminado!"
puts "---------"

puts
puts "Configure  crontab con el siguiente comando: 'whenever --crontab'. Despues puede editarlo con 'crontab -e'"
puts "Configure  passenger y apache y listo!."
puts
puts "Conservar estara disponible en http://#{subdomain}.#{domain}"

