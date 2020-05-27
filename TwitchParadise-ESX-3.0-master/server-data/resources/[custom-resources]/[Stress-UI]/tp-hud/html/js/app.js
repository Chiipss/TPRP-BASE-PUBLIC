window.addEventListener('message', function (event) {


    switch (event.data.action) {
        case 'tick':
            $(".container").css("display", event.data.show ? "none" : "block");
            $("#boxHeal").css("width", event.data.health + "%");
            $("#boxArmor").css("width", event.data.armor + "%");
            $("#boxStamina").css("width", event.data.stamina + "%");
        case 'updateStatus':
            $('#boxHunger').css('width', event.data.hunger + '%');
            $('#boxThirst').css('width', event.data.thirst + '%');
            $('#boxStress').css('width', event.data.stress + '%');
            break;
        case 'showui':
            $('body').fadeIn();
            break;
        case 'hideui':
            $('body').fadeOut();
            break;
        case 'set-voice':
            $("#boxVoice").css("width", event.data.value + "%");
            break;
        case 'voice-color':
            if (event.data.isTalking) {
                $('#boxVoice').addClass('active');

            } else {
                $('#boxVoice').removeClass('active');
                
            }
            break;
    }
});

function formatCurrency(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}