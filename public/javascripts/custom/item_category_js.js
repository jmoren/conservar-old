$(function(){
  $('.remote_link').click(function(){
    var id = $(this).attr('id')
    $('tr#generic_'+id).html('<td><img src="/images/loading.gif" style="float:left;margin: 4px 4px 0 0"><span> eliminando...</span></td>');
  });
})

