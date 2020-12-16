$(function () {


	window.addEventListener('message', function(event) {
		if (event.data.action == "setValue") {
			setValue(event.data.key, event.data.value);
		} else if (event.data.action == "updateStatus") {
			updateStatus(event.data.status);
		} else if (event.data.action == "timer") {
			timer(event.data.value, event.data.key, event.data.gang);
		}	else if (event.data.action == "gang") {
			gang(event.data.value);
		}	else if (event.data.action == "mafia") {
			mafia(event.data.value);
		
		} else if (event.data.action == "setTalking") {
			setTalking(event.data.value);
		} else if (event.data.action == "setProximity") {
			setProximity(event.data.value);
		} else if (event.data.action == "toggle") {
			if (event.data.show) {
				$('#ui').show();
			} else {
				$('#ui').hide();
			}
		}
		 else if (event.data.action == "on") {
		
				$('#ui').show();
			
		}
		else if (event.data.action == "off") {
		
				$('#ui').hide();
			
		}
	});
});

function removeElement(id) {
	if(document.getElementById(id) != null) {
    var elem = document.getElementById(id);
    return elem.parentNode.removeChild(elem);
		}
}

function timer(value, key, gang) {
		
		 if(value == 0) {
			removeElement("timer");

			if (gang == true) {
				$(".playerStats").css('top', '78%');
			} else {
				$(".playerStats").css('top', '78%');
			}
			
		} else {

			if (gang == true) {
				$(".playerStats").css('top', '78%');
			} else {
				$(".playerStats").css('top', '78%');
			}

			
		

		removeElement("timer");

		var div = "<div id='timer'> <span class='timer' id='time'>  <strong>"+key+": </strong>" +value+ "</span></div>";
		$(".playerStats").prepend(div);
	}
}

function mafia(key) {

		$(".playerStats").css('top', '78%');


		var div = "<div id='gangs' style='margin-top: 14px;'> <span class='gangs' id='gang'>  <strong>👑 Mafija: </strong>" +key+ "</span></div>";
		$(".playerStats").append(div);


}

function gang(key) {

		$(".playerStats").css('top', '78%');


		var div = "<div id='gangs' style='margin-top: 14px;'> <span class='gangs' id='gang'>  <strong>⚔️ Gauja: </strong>" +key+ "</span></div>";
		$(".playerStats").append(div);


}

function setValue(key, value) {
	$('#' + key).html(value);
}

function updateStatus(status) {
	var hunger = status[0];
	var thirst = status[1];
	var drunk = status[2];
	$('#hunger .bg').css('height', hunger.percent + '%');
	$('#water .bg').css('height', thirst.percent + '%');
	$('#drunk .bg').css('height', drunk.percent + '%');
}

function setProximity(value) {
	var speaker = 2;
	if (value == "whisper") {
		speaker = 1;
	} else if (value == "normal") {
		speaker = 2;
	} else if (value == "shout") {
		speaker = 3;
	}
	$('#voice img').attr('src', 'img/speaker' + speaker + '.png');
}	

function setTalking(value) {
	if (value) {
		$('#voice').css('border', '3px solid #03A9F4');
	} else {
		$('#voice').css('border', 'none');
	}
}

//API Shit
function colourGradient(p, rgb_beginning, rgb_end) {
    var w = p * 2 - 1;
    var w1 = (w + 1) / 2.0;
    var w2 = 1 - w1;
    var rgb = [parseInt(rgb_beginning[0] * w1 + rgb_end[0] * w2), parseInt(rgb_beginning[1] * w1 + rgb_end[1] * w2), parseInt(rgb_beginning[2] * w1 + rgb_end[2] * w2)];
    return rgb;
};