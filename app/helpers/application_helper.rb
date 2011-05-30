module ApplicationHelper
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
    if report.start_date.nil? || report.end_date.nil?
      content_tag(:div,"Status: #{report.status.titleize}", :style => "float:left;")
    else
      remaining = (report.end_date.to_date - Time.now.to_date)
      css_class = nil
      if remaining <= 0
        css_class = "alert"
      elsif 0 < remaining && remaining < 3
        css_class = "info"
      else
        css_class = "circle-check"
      end
      if report.closed?
        content_tag(:div,"Status: <strong>#{report.status.titleize}</strong>".html_safe, :style => "float:left")+
          content_tag(:div, nil, :class=>"clear")
      else
        content_tag(:div,:class => css_class) do
          content_tag(:span,nil,:style=>"float:left; margin: 2px 3px 2px 0;", :class =>"ui-icon ui-icon-#{css_class}") +
          content_tag(:span,"Status: #{report.status.titleize}", :style =>"float: left;margin: 2px 0")+
          content_tag(:span,"<strong>#{remaining <= 0 ? 'Later about ' + distance_of_time_in_words(report.end_date,Time.now) : 'Remaining time: ' + distance_of_time_in_words(Time.now, report.end_date)}</strong> <small>( #{l report.start_date,:format => :long } - #{ l report.end_date,:format => :long } ) </small>".html_safe,:style =>"float:right;margin: 2px 0") +
          content_tag(:div, nil, :class=>"clear")
        end
      end
    end
  end

  def statics_report(report)
    total  = report.deteriorations.size.to_f
    finish = report.deteriorations.where(:fixed => true).size.to_f
    open   = report.deteriorations.where(:fixed => false).size.to_f
    content_tag(:span, content_tag(:span,"Report complete: #{number_to_percentage((finish/total)*100, :precision => 1) }"),:style => "font-weight:bold;")
  end
end

