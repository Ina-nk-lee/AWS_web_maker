import { useState, useEffect } from 'react';
import reactLogo from './assets/react.svg';
import viteLogo from '/vite.svg';
import axios from 'axios';
import './App.css';

function App() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    axios.get(`${process.env.AWS_ECS_BACKEND_ENDPOINT}/count`)
      .then(response => {
        setCount(response.data.count);
      })
      .catch(error => {
        console.error('Error: ', error);
      });
  }, []);

  const increment = () => {
    const newCount = count + 1;
    axios.post(`${process.env.AWS_ECS_BACKEND_ENDPOINT}/count`, { count: newCount })
      .catch(error => {
        console.error('Error:', error);
      });
    setCount(newCount);
  };

  return (
    <>
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={increment}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </>
  );
}

export default App;