$(document).ready(function(){

  $("#new_todo").keyup(function (e) {
      if (e.keyCode == 13) {
          console.log("You Clicked Me")

        request = $.ajax({
          url: "/todos",
          method: "POST",
          data: $(this).serialize(),
          dataType: "json"
        })

        request.done(function(responseData){
          $('.todo_list').append(new_task_item(responseData))

        })
      }
  });

  $('.todo_list').on('click', '.button_to', function(e) {
      e.preventDefault()
      var url = $(this).attr('action')
      var method = ''
      if (url.length > 10) {
        method = 'put'
      }
      else {
        method = 'delete'
      }

      var request = $.ajax({
        url: url,
        method: method,
        dataType: 'json'
      })

      request.done(function(responseData) {
        console.log(responseData)
        if (method === 'delete') {
           $('#' + responseData.id).remove()
        }
        else {
          $('#' + responseData.id + ' td:nth-child(2)').html(responseData.completed)
        }
      })
  })

$('.todo_edit').dblclick(function(){
    // ajax here


})

})

var new_task_item = function(task){
  debugger
  var html = '<tr id="' + task.id + '"><td class="todo_edit">' + task.description +'</td><td>' + task.completed + '</td><td><form class="button_to" method="get" action="/todos/'+ task.id +'/edit"><input type="submit" value="Edit"></form></td><td><form class="button_to" method="post" action="/todos/' +task.id +'"><input type="hidden" name="_method" value="delete"><input type="hidden" name="authenticity_token" value="' + task.authenticity_token + '"><input type="submit" value="Delete"></form></td><td><form class="button_to" method="post" action="/todos/'+task.id+'?completed=true"><input type="hidden" name="_method" value="put"><input type="submit" value="Complete"></form></td></tr>'
  return html
}










