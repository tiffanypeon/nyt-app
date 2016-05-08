NYTD = {
  render_section_front: function(data) {
    debugger
    console.log(data);
  }
}
$(function() {
  $("#olderStories").click( function(){
    jQuery.ajax({
      url: 'http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion.js',
      jsonp: 'myCallback',
      contentType: 'application/javascript',
      dataType: "jsonp",
      data: {NYTD:1},
      type: "GET",
      success: function(response){
        debugger;
        console.log(response)
      }
   });
  });
});

