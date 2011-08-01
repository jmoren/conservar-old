class Alert < ActiveRecord::Base
  belongs_to :alertable, :polymorphic => true
  belongs_to :user
  attr_accessible :alertable_type, :alertable_id, :message, :frequency, :custom, :user_id, :day

  FREQUENCY = [['Diario','1'],['Semanal','7'],['Quincenal','15'],['Mensual','30']]
  DAYS = [['Lunes','1'],['Martes','2'],['Miercoles','3'],['Jueves','4'],['Viernes','5']]

  validates_presence_of :message

end

