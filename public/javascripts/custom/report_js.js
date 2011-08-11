$(function(){
  $('.observation').live("hover",function(){
    $(".observation_body").editInPlace({
        url: '/observations/update_in_place',
        saving_image: '/images/loading.gif',
        params: 'field=body',
        field_type: "textarea",
    		textarea_rows: "3",
      	textarea_cols: "64",
      	bg_out: "#f1f1f1"
    });
    $('.remove_obs').click(function(){
      var id = $(this).attr('id');
      $('#observation_'+id).html('<div style="text-align:center;margin-top: 20px;min-height:60px"><img src="/images/loading.gif"> eliminando... </div>');
    })
  });
});

