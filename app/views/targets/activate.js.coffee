$target = $('tr[data-id="<%= @target.id %>"]')
$(".active-target.disabled").removeClass("disabled").val("Activate")
$btn = $target.find(".active-target").addClass("disabled").val("Active")