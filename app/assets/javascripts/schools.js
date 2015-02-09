$(document).ready(function() {
  $('.dtable').DataTable({
    "pageLength": 15,
    "lengthMenu": [ [10, 15, 25, 50, -1], [10, 15, 25, 50, "All"] ],
    "order": [[ 1, "asc" ]],
    "dom": 'T<"clear">lfrtip',
    "tableTools": {
          "sSwfPath": "http://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf"
    }
  })
});
