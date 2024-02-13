import React, { useState } from 'react';
import './App.css';

import web3 from 'web3';


function App() {
  const [employerAddress, setEmployerAddress] = useState('');
  const [latitude, setLatitude] = useState('');
  const [longitude, setLongitude] = useState('');
  const [timestamp, setTimestamp] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Check if MetaMask is installed and connected
    if (typeof window.ethereum !== 'undefined') {
      const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
      const account = accounts[0];

      const contractAddress = 'CONTRACT_ADDRESS'; // Replace with the actual contract address on the Sepolia testnet

      // Prepare the transaction data
      const transactionData = {
        from: employerAddress,
        to: contractAddress,
        value: '5000000000000000000', // 5 ETH in wei
        data: '0x', // The function call data if needed
      };

      // Send the transaction
      try {
        await window.ethereum.request({
          method: 'eth_sendTransaction',
          params: [transactionData],
        });

        console.log('Transaction sent successfully');
      } catch (error) {
        console.error('Failed to send transaction:', error);
      }
    } else {
      console.error('MetaMask is not installed or not connected');
    }

    // Reset the input fields
    setEmployerAddress('');
    setLatitude('');
    setLongitude('');
    setTimestamp('');
  };

  return (
    <div className="App">
      <header className='App-header'>
        <h1 className='title'>Admin Page</h1>

        <form onSubmit={handleSubmit}>
          <div className='employer-address'>
            <label htmlFor="employer-address" className='emp_label'>Employer Address:</label>
            <input
              type="text"
              id="employer-address"
              value={employerAddress}
              onChange={(e) => setEmployerAddress(e.target.value)}
              placeholder="Enter employer address"
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