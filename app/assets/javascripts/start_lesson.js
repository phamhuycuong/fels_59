$(document).ready(function() {

  numberMax = parseInt($('.result:last').attr('number'));

  $('.realtime').html("1/"+(numberMax + 1));

  $( "#next" ).click(function() {
    number = parseInt($('.result:visible').attr('number'));
    if (number < numberMax) {
      $('.result').hide();
      number = number + 1;
      $('.result').eq(number).show();
      $('.realtime').html((number + 1).toString()+"/"+(numberMax + 1));
    };
  });

  $( "#prev" ).click(function() {
    number = parseInt($('.result:visible').attr('number'));
    if (number > 0) {
      $('.result').hide();
      number = number - 1;
      $('.result').eq(number).show();
      $('.realtime').html((number + 1).toString()+"/"+(numberMax + 1));
    };
  });

  for (var i = 0; i < 20; i++) {
    $( "#"+i.toString()).click(function() {
      if (this.checked) {
        document.getElementById("answer"+this.id).style.display = "none";
      }
    });
    document.getElementById(i.toString()).checked = false;
  };

  $( "#add").click(function() {
    numberMax = parseInt($('.answer_fields:visible:last').attr('number'));
    document.getElementById((numberMax+1).toString()).checked = false;
    document.getElementById("as"+(numberMax+1).toString()).value = "";
    document.getElementById("answer"+(numberMax+1).toString()).style.display = "";
  });

});
