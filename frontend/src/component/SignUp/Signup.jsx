import React from "react";
import "../signIn/signin.css";
import { Link } from "react-router-dom";

function Signup() {
  return (
    <div className="conatiner">
      <div className="row p-0 m-0">
        <div
          className="col-md-7 p-0 m-0"
          style={{ backgroundColor: "black", width: "60%", height: "100vh" }}
        >
          <div className="container p-0 m-0">
            <img
              src="/media/image/image.webp"
              alt="Padhai"
              className="animateBg"
              style={{ backgroundSize: "cover", width: "100%", height: "100vh" }}
            />  
          </div>
        </div>
        <div
          className="col-md-5 p-5"
          style={{ backgroundColor: "white", width: "40%", height: "100vh" }}
        >
          <h2 className="mt-5">Welcome back!</h2>
          <h3 className="mb-3">Register to your account</h3>
          <p1 className="">It's nice to see you</p1>

          <form>
            <div className="form-group">
              <label for="name"> </label>
              <input
                type="text"
                className="form-control"
                id="name"
                placeholder="Your Name"
              ></input>
               <label for="email"> </label>
              <input
                type="email"
                className="form-control"
                id="email"
                placeholder="Your email"
              ></input>
              <label for="password"></label>
              <input
                type="password"
                className="form-control"
                id="password"
                placeholder="Enter new  password"
              ></input>
                 <label for="password"></label>
              <input
                type="password"
                className="form-control"
                id="password"
                placeholder="Confirm password"
              ></input>
              <button
                type="submit"
                className="btn btn-primary mt-3"
                style={{ width: "100%" }}
              >
                Register
              </button>
              <br></br>

              {/* <input type="checkbox" className="mt-3" id="rememberMe"></input>
              <label htmlFor="rememberMe" className="mt-2 p-2">
                {" "}
                Remember me
              </label>
              <a href="#" className="m-5 " style={{ color: "blue" }}>
                Forgot password?
              </a> */}
              <br></br>
              <hr></hr>
              <button type="submit" className=" mt-3" style={{ width: "100%" }}>
                Continue with Google
              </button>
              <br></br>
              <div
                className="justify-content-center, mt-4"
                style={{ textAlign: "center" }}
              >
                <p>
                  Login with your Account?
                  <Link to="/signin
                  " style={{ color: "blue" }}>
                    Login
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

export default Signup;