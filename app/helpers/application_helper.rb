module ApplicationHelper

  ROLES = [['user','user'],['admin','admin']]
  STATUS = [['Abierto','Abierto'],['Cerrado','Cerrado'],['Reabierto','Reabierto']]
  ItemAttributes = [['coleccion','collection'],['categoria','category'],['subcatecoria','subcategory']]
  ITEM_STATUS = [['bueno','bueno'],['regular','regular'],['malo','malo']]
  MESES = [['Enero','1'], ['Febrero','2'],['Marzo','3'],['Abril','4'],['Mayo','5'],['Junio','6'],
           ['Julio','7'],['Agosto','8'],['Septiembre','9'],['Octubre','10'],['Noviembre','11'],['Diciembre','12']]

  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "#", :class => "remove_child")
  end

  def add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
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
      content_tag(:div,"#{Report.human_attribute_name(:status)}: #{report.status.titleize}", :style => "float:left;font-weight:bold")+
          content_tag(:div, nil, :class=>"clear")
    else
      remaining = (report.end_date.to_date - Time.now.to_date).to_i
      css_class = nil
      if remaining <= 0
        css_class = "status-alert"
      elsif 0 < remaining && remaining < 3
        css_class = "status-info"
      else
        css_class = "status-check"
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
                  content_tag(:span,nil,:style=>"float:left; margin: 2px 3px 2px 0;", :class =>"#{css_class}") +
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
      content_tag(:span, content_tag(:span,"#{finish} / #{total} ( #{number_to_percentage((finish.to_f/total.to_f)*100, :precision => 1) })"),:style => "font-weight:bold;")
    else
      content_tag(:span, "0/0 (0.0%)" ,:style => "font-weight:bold;")
    end
  end

  def hours_complete(report)
    if report.tasks.size > 0 && report.hours > 0
      left = report.remaining_hours
      total = report.hours
      cumplidas = total - left
      content_tag(:span,"#{(cumplidas).to_s} / #{total.to_s} ( #{number_to_percentage((cumplidas/total)*100, :precision => 1)} )" ,:style => "font-weight:bold;")
    else
      content_tag(:span, "0hs. / 0hs. (0.0%)" ,:style => "font-weight:bold;")
    end
  end

  def tasks_complete(report)
    if report.tasks.size > 0
      total = report.tasks.size
      total_closed = report.tasks.where('closed_at is not null').size
      content_tag(:span,"#{(total_closed).to_s} / #{total.to_s} ( #{number_to_percentage((total_closed/total)*100, :precision => 1)} )" ,:style => "font-weight:bold;")
    else
      content_tag(:span, "0 / 0 (0.0%)" ,:style => "font-weight:bold;")
    end
  end

  def deterioration_hours(deterioration)
    if deterioration.tasks.size > 0
      total = deterioration.hours
      left = deterioration.remaining_hours
      complete = total - left
      content_tag(:span,"Diagnosticos terminados: #{(complete).to_s} hs. / #{total.to_s} hs. ( #{number_to_percentage((complete/total)*100, :precision => 1)} )" ,:style => "font-weight:bold;")
    else
      content_tag(:span, "Diagnosticos terminados: 0hs. / 0hs. (0.0%)" ,:style => "font-weight:bold;")
    end
  end
  def page_entries_info(collection)
    content_tag :div, :class => "page_info" do
      collection_name = collection.klass.model_name.human
      total = collection.klass.count
      if collection.count > 0
        "#{collection.offset_value + 1} - #{collection.offset_value + collection.length}  #{collection_name.pluralize.downcase}"
      end
    end
  end

  def search_page_entries_info(collection)
    content_tag :div, :class => "page_info" do
      collection_name = collection.klass.model_name.human
      total = collection.offset_value + collection.length
      if collection.count > 0
        "#{collection.offset_value + 1} - #{collection.offset_value + collection.length} #{collection_name.pluralize.downcase}"
      end
    end
  end
  def version_item(v)
    "#{v.item_type.classify.constantize.model_name.human} - ID ##{v.item_id}"
  end
end

