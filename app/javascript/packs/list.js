import Rails from '@rails/ujs';

document.addEventListener('turbolinks:load', () => {
  let tasks = document.querySelectorAll('.task-check')
  
  
tasks.forEach(function(task) {
  let listID = document.querySelector('#list_id').dataset.listId;
  
  task.addEventListener('change', function(e) {
    let taskID = e.target.dataset.taskId;

    Rails.ajax({
      url: `/lists/${listID}/tasks/${taskID}/toggle_check`,
      type: 'PUT',
      success: function(data) {
      },
      error: function(data) {
      }
    })
  })
  
})

  })
