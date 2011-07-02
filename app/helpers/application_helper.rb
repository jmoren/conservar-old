module ApplicationHelper

  ROLES = [['user','user'],['admin','admin']]
  STATUS = [['Abierto','Abierto'],['Cerrado','Cerrado'],['Reabierto','Reabierto']]

  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "#", :class => "remove_child")
  end

  def add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child",:style => "margin-left:10px;", :"data-association" => association)
  end

  def new_child_fields_template(form_builder,association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f
    content_tag(:div, :id => "#{association}_fields_template",:class=> "fields" ,:style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end

  def report_status(report)
    if (report.start_date.nil? && report.end_date.nil?) || report.end_date.nil?
      content_tag(:div,"#{Report.human_attribute_name(:status)}: #{report.status.titleize}", :style => "float:left;")+
          content_tag(:div, nil, :class=>"clear")
    else
      remaining = (report.end_date.to_date - Time.now.to_date).to_i
      css_class = nil
      if remaining <= 0
        css_class = "alert"
      elsif 0 < remaining && remaining < 3
        css_class = "info"
      else
        css_class = "circle-check"
      end
      if report.closed?
        content_tag(:div,"#{Report.human_attribute_name(:status)}: <strong>#{report.status.titleize}</strong>".html_safe, :class=> "#{report.status.downcase}",:style => "float:left")+
          content_tag(:div, nil, :class=>"clear")
      else
        if report.start_date.nil? || (report.start_date > Time.now.to_date)
          days = distance_of_time_in_words(report.start_date.nil? ? Time.now : report.start_date, report.end_date)
        else
          days = distance_of_time_in_words(Time.now,report.end_date)
        end

        text1 =  content_tag(:div,:class => css_class) do
                  content_tag(:span,nil,:style=>"float:left; margin: 2px 3px 2px 0;", :class =>"ui-icon ui-icon-#{css_class}") +
                  content_tag(:span,"#{Report.human_attribute_name(:status)}: #{report.status.titleize}", :style =>"float: left;margin: 2px 0") +  content_tag(:div, nil, :class=>"clear")
        end
        text2 = content_tag(:span,"<br><strong>#{remaining <= 0 ? 'Se paso ' + distance_of_time_in_words(report.start_date,Time.now) : 'Tiempo restante: ' + days}</strong><br> <small>#{l (report.start_date.nil? ? Time.now.to_date : report.start_date),:format => :short } - #{ l report.end_date,:format => :short }</small>".html_safe,:style =>"float:left;margin: 0") + content_tag(:div, nil, :class=>"clear")
        return content_tag(:div, text1 + text2 )
      end
    end
  end

  def deteriorations_complete(report)
    if report.deteriorations.size > 0
      total  = report.deteriorations.size
      finish = report.deteriorations.where(:fixed => true).size
      open   = report.deteriorations.where(:fixed => false).size
      content_tag(:span, content_tag(:span,"#{finish}/#{total} ( #{number_to_percentage((finish.to_f/total.to_f)*100, :precision => 1) })"),:style => "font-weight:bold;")
    else
      content_tag(:span, "0/0 (0.0%)" ,:style => "font-weight:bold;")
    end
  end

  def hours_complete(report)
    if report.tasks.size > 0
      left = report.remaining_hours
      total = report.hours
      cumplidas = total - left
      content_tag(:span,"#{(cumplidas).to_s} / #{total.to_s} ( #{number_to_percentage((cumplidas/total)*100, :precision => 1)} )" ,:style => "font-weight:bold;")
    else
      content_tag(:span, "0hs. / 0hs. (0.0%)" ,:style => "font-weight:bold;")
    end
  end
  def deterioration_hours(deterioration)
    if deterioration.tasks.size > 0
      total = deterioration.hours
      left = deterioration.remaining_hours
      complete = total - left
      content_tag(:span,"Diagnostico terminado: #{(complete).to_s} hs. / #{total.to_s} hs. ( #{number_to_percentage((complete/total)*100, :precision => 1)} )" ,:style => "font-weight:bold;")
    else
      content_tag(:span, "Diagnostico terminado: 0hs. / 0hs. (0.0%)" ,:style => "font-weight:bold;")
    end
  end
end

