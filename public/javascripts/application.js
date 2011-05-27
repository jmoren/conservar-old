$(function(){
    // dinamic fields
    $('form a.add_child').click(function() {
      var assoc   = $(this).attr('data-association');
      var content = $('#' + assoc + '_fields_template').html();
      var regexp  = new RegExp('new_' + assoc, 'g');
      var new_id  = new Date().getTime();
      $(this).after().before(content.replace(regexp, new_id));
      return false;
    });
    $('form a.remove_child').live('click', function() {
      var hidden_field = $(this).prev('input[type=hidden]')[0];
      if(hidden_field) {
        hidden_field.value = '1';
      }
      $(this).parents('.fields').hide();
      return false;
    });

    // buttons
    $('.remove_deterioration a').button({
        icons: {
            primary: "ui-icon-trash"
        },
        text: false
    });
    $('.button.edit_task').button({
        icons: {
            primary: "ui-icon-pencil"
        }
    });
    $('.button.delete_task').button({
        icons: {
            primary: "ui-icon-trash"
        }
    });
    $('.remove_tool a').button({
        icons: {
            primary: "ui-icon-trash"
        },
        text: false
    });
    $('#add_field a').button({
        icons: {
            primary: "ui-icon-circle-plus"
        }
    });

    $('.new_task.button a').button({
        icons: {
            primary: "ui-icon-plus"
        }
     });
     $('.det_back.button a').button({
        icons: {
            primary: "ui-icon-arrowreturnthick-1-w"
        }
     });

    $('.close_report.button a').button({
        icons: {
            primary: "ui-icon-check"
        }
     });
    $('.pdf.button a').button({
        icons: {
            primary: "ui-icon-print"
        }
     });
    $('.open_task.button a').button({
        icons: {
            primary: "ui-icon-locked"
        }
    });
    $('.close_task.button a').button({
      icons: {
        primary: "ui-icon-unlocked"
      }
    });
    // datepickers
    $("#report_start_date" ).datepicker({dateFormat:"DD, d MM yy"});
    $("#report_end_date").datepicker({dateFormat:'DD, d MM, yy' });
    // select deteriorations task form
    $(function(){
      //Update agent filter using the selected agency:
      $("select#task_deterioration_id").change(function(){
        $.getJSON( "/deterioration",{det_id: $(this).val(), ajax: 'true'}, function(deterioration){
          if (deterioration){
            if (deterioration.deterioration.fixed){
              image = '/images/closed.png'
            }else{
              image = '/images/open.png'
            }
            var template =
            '<div id="deterioration_info" style="border:solid 2px #999;border-radius: 5px; padding: 5px; margin-right:20px">' +
              '<span style="float:right"><img src="' + image +'"></span>'+
              '<strong> Deterioration #'+ deterioration.deterioration.id +'</strong>' +
              '<span style="margin-left: 50px;"> <strong>Category:</strong>  '+ deterioration.deterioration.category +'</span>'+
              '<div class="clear"></div>'+
              '<span style="float:left;width:15%;"> <strong> Description: </strong></span>'+
              '<span style="float:left;margin-left: 10px;min-height:120px">'+
                 deterioration.deterioration.description +
              '</span><div class="clear"></div>'
            $("#deterioration_info").html(template);
           }else{
            var missing_det = '<div id="deterioration_info" style="float:rigth; border:solid 2px #999;border-radius: 5px; padding: 5px; margin-right: 20px; text-align:center;min-height:145px"><p><img src="/images/open.png" ></p><p> <strong style="margin:10px">Select a deterioration</strong></p></div>'
            $("#deterioration_info").html(missing_det);
           }
          })
        })
    });
    hideFlash();
  });
function hideFlash() {
  var flash_div = $(".flash");
  setTimeout(function() { flash_div.slideUp(2000, function() { flash_div.html(""); flash_div.hide(); })}, 3000);
}

