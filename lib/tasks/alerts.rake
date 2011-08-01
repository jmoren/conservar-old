# encoding: utf-8
require "logger"

namespace :alerts do
  desc "Envio de alertas"
  task :send => :environment do

    log = Logger.new(Rails.root.join("log", "alertas.log"))
    log.info("Envio de alertas del #{Date.today}")
    @alerts = Alert.all
    @alerts.each do |alert|
      freq = alert.frequency || alert.custom
      to_be_sended = (alert.updated_at + freq.to_i.days).to_date == Date.today
      if to_be_sended
        #send email
        log.info("\n Alerta ##{alert.id}\tEnvio de alerta a #{alert.user.email}. Proximo envio sera el #{Date.today + freq.days}" )
        alert.touch # actualizamos para el proximo envio
      end        
    end
    log.info("---------------------------------------------")
  end
end

