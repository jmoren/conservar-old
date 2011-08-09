$(function(){
  $('.remote_link').live("click",function(){
      var id = $(this).attr('id');
      $('#user_'+id).html('<div style="width:40%;margin:10px auto"><img style="float:left;margin: 3px" src="/images/loading.gif"> <div style="float:left;margin: 1px 3px">espere...</div></div>');
    });
});

