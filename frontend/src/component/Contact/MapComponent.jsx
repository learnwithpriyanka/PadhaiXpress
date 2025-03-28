import React from "react";
import { MapContainer, TileLayer, Marker, Popup } from "react-leaflet";
import "leaflet/dist/leaflet.css";

const MapComponent = () => {
  const position = [16.4419, 80.6220]; // Coordinates for New Delhi

  return (
    <MapContainer center={position} zoom={13} style={{ height: "747px", width: "100%" ,borderRadius:"20px"}}>
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      />
      <Marker position={position}>
        <Popup>Hello! This is New Delhi.</Popup>
      </Marker>
    </MapContainer>
  );
};

export default MapComponent;
