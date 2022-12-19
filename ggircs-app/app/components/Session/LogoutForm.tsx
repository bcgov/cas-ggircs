import React from "react";

const LogoutForm: React.FC = () => {
  return (
    <>
      <a>
        <form action="/logout" method="post">
          <input type="submit" value="Logout" />
        </form>
      </a>
      <style jsx>{`
        form {
          margin-top: auto;
          margin-bottom: auto;
        }
        input {
          background: none !important;
          border: none;
          padding: 0 !important;
          color: #fff;
        }
        input:hover {
          border-bottom: 1px solid #fff;
        }
      `}</style>
    </>
  );
};

export default LogoutForm;
