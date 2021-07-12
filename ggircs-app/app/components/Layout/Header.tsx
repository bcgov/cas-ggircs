import React, { useState, useRef } from "react";
import Link from "next/link";
import LoginButton from "components/LoginButton";
import Navigation from "@button-inc/bcgov-theme/Navigation";

const DESKTOP_BREAKPOINT_QUERY = "(min-width: 992px)";

const Header = ({ isLoggedIn = false, children }) => {
  let mediaMatch;
  /**
   * Window isn't available at first for statically optimized pages like the 404 page:
   */
  try {
    mediaMatch = window.matchMedia(DESKTOP_BREAKPOINT_QUERY);
  } catch (error) {
    console.error(error);
  }

  const desktopMediaQuery = useRef(mediaMatch);
  const [navMenuHidden, setNavMenuHidden] = useState(
    desktopMediaQuery.current && !desktopMediaQuery.current.matches
  );

  const toggleNavMenu = () => {
    setNavMenuHidden((prev) => {
      // Ensure nav menu is never hidden on desktop
      if (desktopMediaQuery.current && desktopMediaQuery.current.matches)
        return;
      return !prev;
    });
  };

  return (
    <>
      <Navigation
        header="main"
        mobileBreakPoint={800}
        onBannerClick={toggleNavMenu}
        title="Greenhouse Gas Industrial Reporting and Control System"
      >
        <ul
          className="header-right"
          style={navMenuHidden ? { display: "none" } : { marginLeft: "auto" }}
        >
          {isLoggedIn ? (
            <>
              <li>
                <Link href="/">
                  <a>Dashboard</a>
                </Link>
              </li>
              <li>
                <Link href="/user/profile">
                  <a>Profile</a>
                </Link>
              </li>
              <li>
                <Link href="/logout">
                  <a>Logout</a>
                </Link>
              </li>
            </>
          ) : (
            <li>
              <LoginButton />
            </li>
          )}
        </ul>
        {children}
      </Navigation>

      <style jsx>
        {`
          /* Mobile-first styles:
          * Justified flex layout accommodating a smaller logo and main nav
          * is accessible behind hamburger menu instead of button links.
          */

          .nav-header {
            background-color: #036;
            border-bottom: 2px solid #fcba19;
            padding: 10px;
            color: #fff;
          }
          h2 {
            font-weight: normal;
            font-size: calc(1rem + 1vw);
            margin: 0 0.5em;
            text-align: center;
          }
          .header-left {
            display: flex;
            align-items: center;
            width: 100%;
            justify-content: space-between;
          }
          .header-left img {
            height: 46px;
          }
          .header-right {
            display: flex;
            flex-direction: column;
            width: 100%;
            text-align: right;
            margin: 0;
            padding: 0.8em 1em 0 0;
          }
          nav {
            display: flex;
            flex-direction: column;
            align-items: center;
          }
          li {
            list-style-type: none;
          }
          button {
            background: none;
            border: none;
          }
          .nav-button {
            color: #f8f9fa;
            display: inline-block;
            text-align: center;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.25rem;
            transition: color 0.15s ease-in-out,
              background-color 0.15s ease-in-out, border-color 0.15s ease-in-out,
              box-shadow 0.15s ease-in-out;
          }

          /* Small desktop and up:
          * Replaces hamburger menu with button links and pushes apart .header-left
          * (logo + title) and .header-right (nav buttons) content
          */
          @media screen and ${DESKTOP_BREAKPOINT_QUERY} {
            nav {
              flex-direction: row;
              justify-content: space-between;
              padding: 0 15px;
            }
            .header-left {
              width: auto;
            }
            header h2 {
              margin: 0 0 0 18px;
            }
            button#menu-toggle {
              display: none;
            }
            .header-right {
              flex-direction: row;
              width: auto;
              text-align: right;
              margin: 0;
              padding: 0;
            }
            .nav-button {
              border-color: #f8f9fa;
            }
            li {
              padding-left: 12px;
            }
          }

          /* Custom query to prevent title heading from wrapping in screen widths
          * between 992px to 1092px:
          */
          @media screen and (min-width: 1092px) {
            header h2 {
              font-size: 1.5rem;
            }
          }

          /* Larger desktops and up:
          * Gives same effect as .container class on nav to align its contents
          * with page grid:
          */
          @media screen and (min-width: 1200px) {
            nav {
              max-width: 1140px;
              margin-left: auto;
              margin-right: auto;
            }
          }
        `}
      </style>
    </>
  );
};

export default Header;
