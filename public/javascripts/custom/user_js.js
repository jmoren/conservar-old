$(function(){
  $('.remote_link').live("click",function(){
      var id = $(this).attr('id');
      $('#user_'+id).html('<div style="width:40%;margin:10px auto"><img style="float:left;margin: 3px" src="/images/loading.gif"> <div style="float:left;margin: 1px 3px">espere...</div></div>');
    });
  $(".remove_item").click(function(){
    var id = $(this).attr('id');
    $('#item_'+id).html("<div style='text-align:center;margin-top: 10px;min-height:90px'><img src='/images/loading.gif'> desmarcando...</div>");
  });
  $('.close_info').click(function(){
    var data = $(this).attr('data');
    $('#'+data).slideToggle();
    $(this).toggleClass('minus plus');
    return false;
  })
  $('.close_table').click(function(){
    var data = $(this).attr('data');
    $('#'+data).fadeToggle();
    return false;
  })
});

