$(function(){
  $("form").submit(function(event){
    event.preventDefault();

    var action = $(this).attr('action');
    var method = $(this).attr('method');

    var skill = $(this).find('#skill_skill').val();
    var skilllevel = $(this).find('#skill_skilllevel').val();
    var description = $(this).find('#skill_description').val();

    var data = $(this).serializeArray();

    $.ajax({
      method: method,
      url: action,
      data: data,

      dataType: 'script'
    });
  });
});
