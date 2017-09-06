/**
* Control the Open tag page.
*
* by Alex @2017/8/23
*/
var $dialog = null;

jQuery.showModalDialog = function(options) {

	var defaultOptns = {
		url: null,
		dialogArguments: '',
		height: 'auto',
		width: 'auto',
		position: 'center',
		resizable: true,
		scrollable: true,
		onClose: function() { },
		returnValue: null,
		doPostBackAfterCloseCallback: false,
		postBackElementId: null
	};

	var fns = {
		close: function() {
			opts.returnValue = $dialog.returnValue;
			$dialog = null;
			opts.onClose();
			if (opts.doPostBackAfterCloseCallback) {
				postBackForm(opts.postBackElementId);
			}
		},
		adjustWidth: function() { $frame.css("width", "100%"); }
	};

	// build main options before element iteration

	var opts = jQuery.extend({}, defaultOptns, options);

	var $frame = jQuery('<iframe id="iframeDialog" />');

	if (opts.scrollable)
		$frame.css('overflow', 'auto');

	$frame.css({
		'padding': 0,
		'margin': 0,
		'padding-bottom': 10
	});

	var $dialogWindow = $frame.dialog({
		autoOpen: true,
		modal: true,
		width: opts.width,
		height: opts.height,
		resizable: opts.resizable,
		position: opts.position,
		overlay: {
			opacity: 0.5,
			background: "black"
		},
		close: fns.close,
		resizeStop: fns.adjustWidth
	});

	$frame.attr('src', opts.url);
	fns.adjustWidth();

	$frame.load(function() {
		if ($dialogWindow) {
			var maxTitleLength = 50;
			var title = jQuery(this).contents().find("title").html();

			if (title.length > maxTitleLength) {
				title = title.substring(0, maxTitleLength) + '...';
			}
			$dialogWindow.dialog('option', 'title', title);
		}
	});

	$dialog = new Object();
	$dialog.dialogArguments = opts.dialogArguments;
	$dialog.dialogWindow = $dialogWindow;
	$dialog.returnValue = null;
}//end jQuery.showModalDialog = function(options)

	function postBackForm(targetElementId) {
		var theform;
		theform = document.forms[0];
		theform.__EVENTTARGET.value = targetElementId;
		theform.__EVENTARGUMENT.value = "";
		theform.submit();
	}

	// function to open THE POPUP
	function openTag(){
		//console.log("window.jsessionid="+window.jsessionid);
		//var url = 'extremedevTestPopup.html';
		//var url = '../../media/jsp/dialog/tagPopup.html;jsessionid='+window.jsessionid;
		
		//var url = '/modules/device/preload/grouppreload.jsp;jsessionid='+window.jsessionid+"?"+ "groupids=8&type=group";
		//var url = '/modules/device/preload/grouppreload.jsp;jsessionid='+window.jsessionid+"?"+ "groupids=8&type=player";
		var url = '/modules/media/jsp/grouptree.jsp;jsessionid='+window.jsessionid+"?"+ "groupids=8&type=player";
		//var url = '/modules/role/jsp/roleWrapper.jsp;jsessionid='+window.jsessionid;
		
		jQuery.showModalDialog({
			 url: url,
			 dialogArguments: 'dialogArguments',
			 height: 500,
			 width: 900,
			 scrollable: false,
			 onClose: function(){ var returnedValue = this.returnValue; }
			 //onClose: function(){ var returnedValue = this.returnValue; alert('This is the returned value from the popup:' + returnedValue); }
		});
	}
