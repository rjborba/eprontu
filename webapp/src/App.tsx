import React from "react";
import "./App.css";
import Button from "@mui/material/Button";
import { useHistory } from "react-router-dom";

function App() {
  return (
    <div className="App">
      <logoHeader />
      <div className="mainMenu">
        <Button variant="contained" onClick={setUserForm}>
          Cadastro
        </Button>
        <Button variant="contained" onClick={getUserForm}>
          Consultar
        </Button>
        <Button variant="contained" onClick={allowUserForm}>
          Autorizar
        </Button>
        <Button variant="contained" onClick={denyUserForm}>
          Desautorizar
        </Button>
      </div>
    </div>
  );
}

export default App;
