import React from "react";
import { useRouter } from "next/router";
import { Form } from "react-bootstrap";

const LoginButton: React.FunctionComponent = () => {
  const router = useRouter();
  let loginURI = "/login";

  if (router.query.redirectTo)
    loginURI += `?redirectTo=${encodeURIComponent(
      router.query.redirectTo as string
    )}`;

  return (
    <Form inline action={loginURI} method="post">
      <button type="submit">Log in</button>
      <style jsx>{`
        button {
          color: #f8f9fa;
          display: inline-block;
          text-align: center;
          user-select: none;
          background-color: transparent;
          border: 1px solid #f8f9fa;
          padding: 0.375rem 0.75rem;
          font-size: 1rem;
          border-radius: 0.25rem;
      `}</style>
    </Form>
  );
};

export default LoginButton;
