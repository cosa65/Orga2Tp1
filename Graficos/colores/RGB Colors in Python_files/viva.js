// Leturstærð

$(document).ready(function(){
  // Reset Font Size
  var originalFontSize = $('#the-content').css('font-size');
  $(".resetFont").click(function(){
  $('#the-content').css('font-size', originalFontSize);
  });
  // Increase Font Size
  $(".increaseFont").click(function(){
  	var currentFontSize = $('#the-content').css('font-size');
 	var currentFontSizeNum = parseFloat(currentFontSize, 10);
    var newFontSize = currentFontSizeNum*1.2;
	$('#the-content').css('font-size', newFontSize);
	return false;
  });
  // Decrease Font Size
  $(".decreaseFont").click(function(){
  	var currentFontSize = $('#the-content').css('font-size');
 	var currentFontSizeNum = parseFloat(currentFontSize, 10);
    var newFontSize = currentFontSizeNum*0.8;
	$('#the-content').css('font-size', newFontSize);
	return false;
  });
});

// Clear Input Text

function clearText(theField)
	{
	if (theField.defaultValue == theField.value)
	theField.value = '';
	}
	
	function addText(theField)
	{
	if (theField.value == '')
	theField.value = theField .defaultValue;
	}


$(document).ready(function() {
    $(function(){
    
    	// Run tooltip
		$(".tooltip").tipTip();

		DD_roundies.addRule('#navigation ul li a', '10px', true);
		
		DD_roundies.addRule('div.footer-box', '5px', true);
		
		DD_roundies.addRule('div.box-title', '5px 5px 0px 0px', true);
		
		DD_roundies.addRule('#logo a', '5px 0px 0px 5px', true);
		
		DD_roundies.addRule('div#navigation', '5px', true);
		
		DD_roundies.addRule('#slide-right', '0px 5px 5px 0px', true);
		
	});		
});