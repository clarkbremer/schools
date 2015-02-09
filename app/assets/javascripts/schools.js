$(document).ready(function() {
    $('.dtable').DataTable({
      "pageLength": 15,
      "lengthMenu": [ [10, 15, 25, 50, -1], [10, 15, 25, 50, "All"] ]
  })
});
