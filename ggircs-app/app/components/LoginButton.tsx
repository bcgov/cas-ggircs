import React from "react";
import { useRouter } from "next/router";

const LoginButton: React.FunctionComponent = () => {
  const router = useRouter();
  let loginURI = "/login";

  if (router.query.redirectTo)
    loginURI += `?redirectTo=${encodeURIComponent(
      router.query.redirectTo as string
    )}`;

  return (
    <form action={loginURI} method="post">
      <button type="submit">Log in</button>
      <style jsx>{`
        button[type="submit"] {
          background: none !important;
          border: none;
          display: flex;
          font-size: 0.813em;
          font-weight: normal;
          color: #fff;
          padding: 0 15px 0 5px;
          text-decoration: none;
          border-right: 1px solid #9b9b9b;
        }
        button[type="submit"]:hover {
          text-decoration: underline;
        }
      `}</style>
    </form>
  );
};

export default LoginButton;
