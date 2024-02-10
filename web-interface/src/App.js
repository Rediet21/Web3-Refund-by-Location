// App.js
import React, { useState } from 'react';
import './App.css';

function App() {
  const [account, setAccount] = useState('');
  const [latitude, setLatitude] = useState('');
  const [longitude, setLongitude] = useState('');
  const [timestamp, setTimestamp] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    // Perform necessary actions with the input data
    console.log('Account:', account);
    console.log('Latitude:', latitude);
    console.log('Longitude:', longitude);
    console.log('Timestamp:', timestamp);
    // Reset the input fields
    setAccount('');
    setLatitude('');
    setLongitude('');
    setTimestamp('');
  };
  
  return (
    <div className="App">
      <header className= 'App-header'>
      <h1 className='title'>Employer Input</h1>
      
      <form onSubmit={handleSubmit}>
        <div className='account'>
          <label htmlFor="account" className='acnt_label'>Account:</label>
          <input
            type="text"
            id="account"
            value={account}
            onChange={(e) => setAccount(e.target.value)}
            placeholder="Enter your account"
            required
          />
        </div>
        
        <p>Put the Location required to reach here</p>
        <label htmlFor="location" className='loc_label'>Location:</label>
          <div className="location-inputs">
            <input className='latitude'
              type="text"
              id="latitude"
              value={latitude}
              onChange={(e) => setLatitude(e.target.value)}
              placeholder="Enter latitude"
              required
            />
            <input className='longitude'
              type="text"
              id="longitude"
              value={longitude}
              onChange={(e) => setLongitude(e.target.value)}
              placeholder="Enter longitude"
              required
            />
        <div/>
      <div/>   
          
        </div>
        <div className='Timestamp'>
          <p>Put the time stamp to reach the location</p>
          <label htmlFor="timestamp" className='time_label'>Timestamp:</label>
          <input
            type="text"
            id="timestamp"
            value={timestamp}
            onChange={(e) => setTimestamp(e.target.value)}
            placeholder="Enter timestamp"
            required
          />
        </div>
        <button type="submit" className='submit'>Submit</button>
      </form>
      </header>
      
    </div>
  );
}

export default App;