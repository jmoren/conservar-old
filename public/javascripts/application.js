$(function(){

    // dinamic fields
    $('form a.add_child').click(function() {
      var assoc   = $(this).attr('data-association');
      var content = $('#' + assoc + '_fields_template').html();
      var regexp  = new RegExp('new_' + assoc, 'g');
      var new_id  = new Date().getTime();
      $("#"+ assoc +"_table").after().after(content.replace(regexp, new_id));
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

	  $("#report_start_date" ).datepicker({
        minDate: -2,
			  dateFormat:"DD, d MM yy",
			  showOtherMonths: true,
  			selectOtherMonths: true
			});
    $("#report_end_date").datepicker({
        minDate: +1,
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
            '<div id="deterioration_info" style="border:solid 2px #999;border-radius: 5px; padding: 5px;">' +
              '<span style="float:right"><img src="' + image +'"></span>'+
              '<span> <strong>Categoria:</strong>  '+ deterioration.category +'</span>'+
              '<div class="clear"></div>'+
              '<span><strong> Descripcion: </strong></span>'+
              '<span>'+
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

