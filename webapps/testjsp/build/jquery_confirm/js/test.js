$(document).ready(function(){
disp_grprompt.click(function()
{
    $.confirm({
                        'title'         : 'Delete Confirmation',
                        'message'       : 'You are about to delete this item. <br />It cannot be restored at a later time! Continue?',
                        'buttons'       : {
                                'Yes'   : {
                                        'class' : 'blue',
                                        'action': function(){
                                        }
                                },
                                'No'    : {
                                        'class' : 'gray',
                                        'action': function(){}  // Nothing to do in this case. You can as well omit the action property.
                                }
                        }
                });
});
});
