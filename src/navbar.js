import React from 'react';
import { Link } from 'react-router-dom';
import './App.css'; // Import only if you're using a separate CSS file

function Navbar() {
  return (
    <nav className="navbar">
      <ul>
        <li>
          <Link to="/">Home</Link>
        </li>
        <li>
          <Link to="/library">Library</Link>
        </li>
      </ul>
    </nav>
  );
}

export default Navbar;
