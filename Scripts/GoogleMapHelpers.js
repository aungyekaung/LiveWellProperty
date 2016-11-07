function init_map(map_canvas_id, lat, lng, zoom, markers) {
    var myLatLng = new google.maps.LatLng(lat, lng);
    
    var options = {
        zoom: zoom,
        center: myLatLng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    var map_canvas = document.getElementById(map_canvas_id);

    var map = new google.maps.Map(map_canvas, options);

    if (markers && markers.length > 0) {
        var bounds = new google.maps.LatLngBounds();

        for (var i = 0; i < markers.length; i++) {
            var marker = new google.maps.Marker(markers[i]);
            marker.setMap(map);

            bounds.extend(marker.getPosition());
        }

        map.fitBounds(bounds);
        map.setCenter(bounds.getCenter());
    }
}