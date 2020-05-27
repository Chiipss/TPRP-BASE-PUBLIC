var notifs = {}

window.addEventListener('message', function (event) {
    ShowNotif(event.data);
});

function CreateNotification(data) {
    let $notification = $(document.createElement('div'));
    $notification.addClass('notification').addClass(data.type);
    $notification.html(data.text);
    $notification.html('\
    <div class="alerts police">\
    <div class="content">\
    <div id="code">' + data.code + '</div>\
    <div id="alert-name">' + data.text + '</div>\
    <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
    <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.location + '</div>\
    </div>');
    $notification.fadeIn();
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }
    return $notification;
}

function ShowNotif(data) {
    if (data.id == null) {
        let $notification = CreateNotification(data);
        $('.notif-container').append($notification);
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);
    }

}