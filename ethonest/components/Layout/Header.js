import styled from "styled-components";
import HeaderLogo from "../HeaderLogo";
import HeaderNav from "../HeaderNav";
import HeaderRight from "../HeaderRight";

const Header = () => {
  return (
    <HeaderWrapper>
      <HeaderLogo></HeaderLogo>
      <HeaderNav></HeaderNav>
      <HeaderRight></HeaderRight>
    </HeaderWrapper>
  );
};

const HeaderWrapper = styled.div`
  width: 100%;
  height: 70px;
  border: 2px solid red;
  display: flex;
  justify-content: space-around;
  align-items: center;
`;

export default Header;
