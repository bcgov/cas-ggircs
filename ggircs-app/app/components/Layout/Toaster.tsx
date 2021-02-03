import React from "react";
import { ToastContainer } from "react-toastify";

export const Toaster: React.FunctionComponent = () => (
  <ToastContainer limit={3} />
);

export default Toaster;
