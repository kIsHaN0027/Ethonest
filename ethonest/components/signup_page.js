const SignupPage = () => {
    return (
        <div className="signuppage">
            <h1 className="signuppageelement" id="element1">Sign up to get started</h1>
            <h3 className="signuppageelement" id="element2">Already have an account? <a href="###">Log in</a></h3>
            <a className="signuppageelement" id="element3"><button id="buttonelement3">Continue with Facebook <imgage id="imageelement3">
            </imgage></button></a>
            <a className="signuppageelement" id="element4"><button id="buttonelement4">Continue with Google </button></a>
            <hr id="element5" />OR<hr id="element6" />
            <form action="###" id="element7">
                <input className="signuppageelement" id="element8" type='email' placeholder="Email"></input>
                <input className="signuppageelement" id="element9" type="password" placeholder="password"></input>
                <button className="signuppageelement" id="element10" type="submit" >Sign Up <p id="paraelement10">&rarr;</p></button>
            </form>
            <h4 id="element11" className="signuppageelement">By signing up you agree to our terms of use, privacy policy. <a href="##3">Read more..</a></h4>
        </div>
    );
};
export default SignupPage;