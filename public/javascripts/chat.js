(function () {
  function Renderer(params) {
      this.render = function (_this) {
          return function () {
              var compiled = _.template($("#message_template").html());
              var $message = $(compiled(params));
              $('.messages').append($message);
              return setTimeout(function () {
                  return $message.addClass('appeared');
              }, 0);
          };
      }(this);
      return this;
  }

  function renderCollection(col){
    col.forEach(function(item){
      var r = Renderer(item);
      r.render();
    });
    scrollToBottom();
  }

  function scrollToBottom() {
    var $messages = $('.messages');
    $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 300);
  }

  function sendMessage(params) {
    if (params.text.trim() === '') {
        return;
    }

    $('.message_input').val('');
    var renderer = new Renderer(params);
    renderer.render();

    scrollToBottom();

    $.ajax({
      type: "POST",
      beforeSend: function(xhr){
        xhr.setRequestHeader("Authorization", "JWT " + localStorage.jwt);
        xhr.setRequestHeader("Content-Type", "application/json");
      },
      url: "http://localhost:3030/messages",
      data: JSON.stringify({
        text: params.text
      })
    })
    .then(function(result){
      $("#"+params.id).attr("id", result.id);
    });
  }

  function guid() {
    function s4() {
      return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
    }
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
      s4() + '-' + s4() + s4() + s4();
  }

  function longPolling(lastId) {
    $.ajax({
      type: "GET",
      beforeSend: function(xhr){
        xhr.setRequestHeader("Authorization", "JWT " + localStorage.jwt);
      },
      url: "http://localhost:3030/message-poll?last_id=" + lastId
    })
    .then(function(result){
      renderCollection(result.items);
      scrollToBottom();

      setTimeout(function(){
        var lastItem = _.last(result.items);
        longPolling(lastItem ? lastItem.id : lastId);
      }, 2000);
    })
  }

  $('.send_message').click(function (e) {
    return sendMessage({
      id: guid(),
      user: currentUser,
      text: $('.message_input').val()
    });
  });

  $('.message_input').keyup(function (e) {
    if (e.which === 13) {
        return sendMessage({
          id: guid(),
          user: currentUser,
          text: $('.message_input').val()
        });
    }
  });

  $.ajax({
    type: "GET",
    beforeSend: function(xhr){
      xhr.setRequestHeader("Authorization", "JWT " + localStorage.jwt);
    },
    url: "http://localhost:3030/messages"
  })
  .then(function(result){
    renderCollection(result.items);
    var lastItem = _.last(result.items);
    longPolling(lastItem ? lastItem.id : null);
  });

  $("#logout").click(function(ev){
    ev.preventDefault();
    localStorage.removeItem("jwt");
    location.href="/";
  });

}.call(this));
