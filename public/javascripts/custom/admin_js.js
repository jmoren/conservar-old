$(function(){

  $("#it").click(function(){
    $("#items").html('<div style="text-align:center;padding-top:50px"><img src="/images/loading2.gif"><p> Buscando...</p></div>')
  });
  $("#reportes").click(function(){
    $("#reportes").html('<div style="text-align:center;padding-top:50px"><img src="/images/loading2.gif"><p> Buscando...</p></div>')
  });
  $("#det").click(function(){
    $("#deteriorations").html('<div style="text-align:center;padding-top:50px"><img src="/images/loading2.gif"><p> Buscando...</p></div>')
  });
   $(".suggestion").editInPlace({
      url: '/admin/det_categories/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=suggestion',
      field_type: "textarea",
		  textarea_rows: "2",
  	  textarea_cols: "60"
    });
    $(".phone").editInPlace({
      url: '/admin/institutions/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=phone',
      size: '20'
    });
    $(".address").editInPlace({
      url: '/admin/institutions/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=address',
      size: '20'
    });
  $(".email").editInPlace({
      url: '/admin/institutions/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=email',
      size: '20'
    });
  $(".name").editInPlace({
      url: '/admin/institutions/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=name',
      size: '20'
    });
  $(".zip").editInPlace({
      url: '/admin/institutions/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=zip',
      size: '20'
    });
  $(".city").editInPlace({
      url: '/admin/institutions/update_in_place',
      saving_image: '/images/loading.gif',
      params: 'field=city',
      size: '20'
    });
  $('#edit_institution').click(function(){
    $('#edit_institution_form').dialog({
      modal:true,
      closeOnEscape: true,
      height: 220,
      width: 350,
      title: "Editar Foto Institucion"
    });
    return false;
  });

});

