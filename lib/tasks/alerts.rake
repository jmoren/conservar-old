# encoding: utf-8
require "logger"

namespace :alerts do
  desc "Envio de alertas"
  task :send => :environment do

    log = Logger.new(Rails.root.join("log", "alertas.log"))
    log.info("Envio de alertas - #{Time.now}")
    @alerts = Alert.all
    @alerts.each do |alert|
      frequency = alert.frequency || alert.custom
      unless frequency.nil?
        case frequency
          when "30"
            freq = 1.month
          when "15"
            freq = 2.weeks
          when "7"
            freq = 1.week
          when "1"
            freq = 1.days
        else
          freq = frequency.to_i.days
        end
        to_be_sended = (alert.updated_at + freq).to_date == Date.today
        if to_be_sended
          AlertMailer.send_alert(alert).deliver
          log.info("\n Alerta ##{alert.id}\tEnvio de alerta a #{alert.user.email}\tProximo envio sera el #{Date.today + freq}" )
          alert.touch # actualizamos para el proximo envio
        end
      else
        log.info("\nAlerta ##{alert.id} no tiene frequency, es un error")
      end
    end
    log.info("----------------------------------------------------------")
  end
end

