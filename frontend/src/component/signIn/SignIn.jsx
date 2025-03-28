import React from "react";
import "./SignIn.css";
import { Link } from "react-router-dom";

function SignIn() {
  return (
    <div className="conatiner ">
      <div className="row   ">
        <div
          className="col-md-7 p-0 m-0"
          style={{ backgroundColor: "black", width: "60%", height: "100vh" }}
        >
          <div className="container p-0 m-0">
            <img src="/media/image/image.webp" alt="Padhai"  className="animateBg" style={{backgroundSize:"cover", width:"100%", height:"100vh"}} />
          </div>
        </div>
        <div
          className="col-md-5 p-5"
          style={{ backgroundColor: "white", width: "40%", height: "100vh" }}
        >
          <h2 className="mt-5">Welcome back!</h2>
          <h3 className="mb-3">Login to your account</h3>
          <p1 className="">It's nice to see you again.Ready to order?</p1>

          <form>
            <div className="form-group">
              <label for="email"> </label>
              <input
                type="email"
                className="form-control"
                id="email"
                placeholder="Your username or email"
              ></input>
              <label for="password"></label>
              <input
                type="password"
                className="form-control"
                id="password"
                placeholder="Enter your password"
              ></input>
              <button
                type="submit"
                className="btn btn-primary mt-3"
                style={{ width: "100%" }}
              >
                Log in
              </button>
              <br></br>

              <input type="checkbox" className="mt-3" id="rememberMe"></input>
              <label htmlFor="rememberMe" className="mt-2 p-2">
                {" "}
                Remember me
              </label>
              <a href="#" className="m-5 " style={{ color: "blue" }}>
                Forgot password?
              </a>
              <br></br>
              <hr></hr>
              <button type="submit" className=" mt-3" style={{ width: "100%", borderRadius:"10px" }}>
                Continue with Google
              </button>
              <br></br>
              <div
                className="justify-content-center, mt-4"
                style={{ textAlign: "center" }}
              >
                <p>
                  Don't have Account ?
                  <Link to="/signup" style={{ color: "blue" }}>
                    Sign Up
                  </Link>
                </p>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}

export default SignIn;