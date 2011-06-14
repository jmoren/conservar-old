# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

categories = DetCategory.create([{:name => "humedad",:suggestion => "Aca va la sugerencia para el tratamiento de problemas relativos a la humedad"},{:name => "insectos",:suggestion => "Aca va la sugerencia para el tratamiento de problemas relativos a los insectos"}])
admin = User.create({:name => "admin", :lastname => "admin", :username => "admin",:email => "admin@conservar.com", :password => "admin123", :password_confirmation => "admin123", :role => "admin"})

