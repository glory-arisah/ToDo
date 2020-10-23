import Rails from '@rails/ujs';

/* window.addEventListener('DOMContentLoaded', (_event) => {
  const editTaskButton = document.querySelectorAll(".task-edit");
  const deleteTaskButton = document.querySelectorAll(".task-delete");
  const checkTask = document.querySelectorAll(".task-check");
  
  if (document.querySelector('#list_id') !== null) {
    let listID = document.querySelector('#list_id').dataset.listId;
    let taskBoxes = document.querySelectorAll(".task-checked");

  taskBoxes.forEach((task_box) => {
    task_box.onchange = function(e) {
      let taskID = task_box.dataset.taskId;
      console.log(taskID)
      console.log('fxtrcjg', listID)
      
      Rails.ajax({
        url: `/lists/${listID}/tasks/${taskID}/toggle_check`,
        type: 'PUT',
        success: function(data) {
          console.log('task is hit')
        },
        error: function(data) {
          console.log('Task is not hit')
        }
      })  
    }
  })
} 
}
)
*/

   function check_task() { 
    let tasksToCheck = document.querySelectorAll(".task-checked")
    taskToCheck.forEach(check_box, function() {
      if (taskToCheck.value == 'yes') {
        check_box.className = 'checked'
        
      }
      else {
        check_box.className = 'unchecked'
      }
    })
  }
  
/*
    let taskID = `${task.id}`
    console.log(taskID)
    console.log('fxtrcjg', listID)
    
    Rails.ajax({
      url: `/lists/${listID}/tasks/${taskID}/toggle_check`,
      type: 'PUT',
      success: function(data) {
        console.log('task is hit')
      },
      error: function(data) {
        console.log('Task is not hit')
      }
    })
    */
