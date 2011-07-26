class Alert < ActiveRecord::Base
  belongs_to :alertable, :polymorphic => true
  belongs_to :user
  attr_accessible :alertable_type, :alertable_id, :message, :frequency, :custom, :user_id, :day

  FREQUENCY = [['Diario','1'],['Semanal','7'],['Quincenal','15'],['Mensual','30']]
  DAYS = [['Lunes','lunes'],['Martes','martes'],['Miercoles','miercoles'],['Jueves','jueves'],['Viernes','viernes']]

  validates_presence_of :message

end

