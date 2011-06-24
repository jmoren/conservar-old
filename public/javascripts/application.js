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
    $('.button.with_text.new a ').button({
      icons:{primary:'ui-icon-plus'}
    });
    $('.button.with_text.unlock a ').button({
      icons:{primary:'ui-icon-unlocked'}
    });
    $('.button.with_text.lock a ').button({
      icons:{primary:'ui-icon-locked'}
    });

    $('.button.with_text.delete a ').button({
      icons:{primary:'ui-icon-trash'}
    });
    $('.button.with_text.print a ').button({
      icons:{primary:'ui-icon-print'}
    });
    $('.button.with_text.show a ').button({
      icons:{primary:'ui-icon-search'}
    });
    $('.button.with_text.edit a ').button({
      icons:{primary:'ui-icon-pencil'}
    });
    $('.button.with_text.back a ').button({
      icons:{primary:'ui-icon-arrowreturn-1-w'}
    });
    $('.button.without_text.new a ').button({
      icons: {
        primary: 'ui-icon-plus'
      },
      text: false
    });
    $('.button.without_text.lock a ').button({
      icons: {
        primary: 'ui-icon-locked'
      },
      text: false
    });
    $('.button.without_text.unlock a ').button({
      icons: {
        primary: 'ui-icon-unlocked'
      },
      text: false
    });

    $('.button.without_text.delete a ').button({
      icons: {
        primary: 'ui-icon-trash'
      },
      text: false
    });
    $('.button.without_text.show a ').button({
      icons: {
        primary: 'ui-icon-search'
      },
      text: false
    });

    // datepickers
    //var dates = $( "#report_start_date, #report_end_date" ).datepicker({
		//	minDate: -2,
			//image calendar
		//	showOn: "button",
  	//		buttonImage: "/images/calendar.gif",
	  //		buttonImageOnly: true,
			  //dateFormat
		//	  dateFormat:"d, MM yy",
	  //		onSelect: function( selectedDate ) {
		//		var option = this.id == "report_start_date" ? "minDate" : "maxDate",
		//			instance = $( this ).data( "datepicker" ),
		//			date = $.datepicker.parseDate(
		//				instance.settings.dateFormat ||
		//				$.datepicker._defaults.dateFormat,
		//			selectedDate, instance.settings );
		//		dates.not( this ).datepicker( "option", option, date );
		//	}
		//});

	  $("#report_start_date" ).datepicker({
        minDate: -2,
        //showOn: "button",
			  //buttonImage: "/images/calendar.gif",
			  //buttonImageOnly: true,
			  dateFormat:"DD, d MM yy",
			  showOtherMonths: true,
  			selectOtherMonths: true
			});
    $("#report_end_date").datepicker({
        minDate: +1,
        //showOn: "button",
			  //buttonImage: "/images/calendar.gif",
			  //buttonImageOnly: true,
			  dateFormat:"DD, d MM yy",
			  showOtherMonths: true,
  			selectOtherMonths: true,
  			onSelect: function( selectedDate ) {
				  var option = this.id == "report_start_date" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
					  selectedDate, instance.settings );
				  dates.not( this ).datepicker( "option", option, date );
			  }
			});
			$.datepicker.regional['es'] = {
		    closeText: 'Cerrar',
		    prevText: '&#x3c;Ant',
		    nextText: 'Sig&#x3e;',
		    currentText: 'Hoy',
		    monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
		    'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
		    monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun',
		    'Jul','Ago','Sep','Oct','Nov','Dic'],
		    dayNames: ['Domingo','Lunes','Martes','Miercoles','Jueves','Viernes','Sabado'],
		    dayNamesShort: ['Dom','Lun','Mar','Mie','Juv','Vie','Sab'],
		    dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sa'],
		    weekHeader: 'Sm',
		    dateFormat: 'dd/mm/yy',
		    firstDay: 1,
		    isRTL: false,
		    showMonthAfterYear: false,
		    yearSuffix: ''
		  };
	  $.datepicker.setDefaults($.datepicker.regional['es']);
    // select deteriorations task form
    $(function(){
      //Update agent filter using the selected agency:
      $("select#task_deterioration_id").change(function(){
        $.getJSON( "/deterioration",{det_id: $(this).val()}, function(deterioration){
          if (deterioration){
            if (deterioration.fixed){
              image = '/images/closed.png'
            }else{
              image = '/images/open.png'
            }
            var template =
            '<div id="deterioration_info" style="border:solid 2px #999;border-radius: 5px; padding: 5px; margin-right:20px">' +
              '<span style="float:right"><img src="' + image +'"></span>'+
              '<strong> Deterioration #'+ deterioration.id +'</strong>' +
              '<span style="margin-left: 50px;"> <strong>Category:</strong>  '+ deterioration.category +'</span>'+
              '<div class="clear"></div>'+
              '<span style="float:left;width:15%;"> <strong> Description: </strong></span>'+
              '<span style="float:left;margin-left: 10px;min-height:120px">'+
                 deterioration.description +
              '</span><div class="clear"></div>'
            $("#deterioration_info").html(template);
           }else{
            var missing_det = '<div id="deterioration_info" style="float:rigth; border:solid 2px #999;border-radius: 5px; padding: 5px; margin-right: 20px; text-align:center;min-height:145px"><p><img src="/images/open.png" ></p><p> <strong style="margin:10px">Select a deterioration</strong></p></div>'
            $("#deterioration_info").html(missing_det);
           }
          })
        })
    });
    //hideFlash();
  });
function hideFlash() {
  var flash_div = $(".flash");
  setTimeout(function() { flash_div.slideUp(2000, function() { flash_div.html(""); flash_div.hide(); })}, 3000);
}

