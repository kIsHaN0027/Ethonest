import Header from "./Header";
import themes from "./themes";
import styled, { ThemeProvider, createGlobalStyle } from "styled-components";
import { useState, createContext } from "react";

const App = createContext();

const Layout = ({ children }) => {
  const [theme, setTheme] = useState("light");
  const changeTheme = () => {
    setTheme(theme === "light" ? "dark" : "light");
  };

  return (
    // <App.Provider value={(changeTheme, theme)}>
    <App.Provider value={changeTheme}>
      <ThemeProvider theme={themes[theme]}>
        {/* <LayoutWrapper onClick={changeTheme}> */}
        <LayoutWrapper>
          <Globalstyle />
          <Header />
          {/* {children} */}
        </LayoutWrapper>
      </ThemeProvider>
    </App.Provider>
  );
};

const Globalstyle = createGlobalStyle`
body{
  margin:0;
  padding:0;
  overflow-x:hidden;
}`;
const LayoutWrapper = styled.div`
  min-height: 100vh;
  background-color: ${(props) => props.theme.bgcolor};
  background-image: ${(props) => props.theme.bgimage};
  color: ${(props) => props.theme.color};
`;
export default Layout;
export { App };
