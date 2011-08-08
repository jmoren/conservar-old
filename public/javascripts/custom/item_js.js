$(function(){
  $('nav.pagination a').live("click",function(){
    $('.result').html('<div><img style="float:left;margin: 3px" src="/images/loading.gif"> <div style="float:left;margin: 1px 3px">buscando...</div></div>');
  });
  $('.remote_link').click(function(){
    $('.result').html('<div><img style="float:left;margin: 3px" src="/images/loading.gif"> <div style="float:left;margin: 1px 3px">buscando...</div></div>');
  });
  $('.selectable').change(function(){
    $('.result').html('<div><img style="float:left;margin: 3px" src="/images/loading.gif"> <div style="float:left;margin: 1px 3px">buscando...</div></div>');
    var id = $(this).val();
    var title = $(this).attr('id');
    $.ajax({
      url: 'items/?'+title+'='+id,
      success: function(){
        $('.loading').hide();
      },
      dataType: 'script'
    });
  })
  $('#item_item_category_id').change(function(){
    $.getJSON( "/items/get_subcategories",{id: $(this).val(), ajax: 'true'}, function(j){
      var options = '';
      for (var i = 0; i < j.length; i++) {
        options += '<option value="' + j[i].id + '">' + j[i].name + '</option>';
      }
      $("#item_item_subcategory_id").html(options);
      $('#subcategory_error').hide();
    })
  });
  $("#item_item_subcategory_id").change(function(){
    if ($("#item_item_subcategory_id").val() == '' ){
      $('#subcategory_error').show();
      return false;
    }else{
      $('#subcategory_error').hide();
    }
  });
  $('.close_vcard_report').click(function(){
    var id = $(this).attr('id');
    $(".vcard_report_"+id).hide();
    return false;
  })
  $('#close_vcard_collection').click(function(){
    $(".vcard_collection").hide();
    return false;
  })
});

