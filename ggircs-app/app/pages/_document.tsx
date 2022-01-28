import Document, { Html, Head, Main, NextScript } from "next/document";

class MyDocument extends Document {
  render() {
    return (
      <Html lang="en">
        <Head>
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <meta charSet="utf-8" />
          <title>Greenhouse Gas Industrial Reporting and Control System</title>
          <link rel="stylesheet" href="/bootstrap.min.css" />
          <link rel="stylesheet" href="/base.css" />
          <link
            rel="apple-touch-icon"
            href="/icons/bcid-apple-touch-icon.png"
            sizes="180x180"
          />
          <link
            rel="icon"
            href="/icons/bcid-favicon-32x32.png"
            sizes="32x32"
            type="image/png"
          />
          <link
            rel="icon"
            href="/icons/bcid-favicon-16x16.png"
            sizes="16x16"
            type="image/png"
          />
          <link
            rel="mask-icon"
            href="/icons/bcid-apple-icon.svg"
            color="#036"
          />
          <link rel="icon" href="/icons/bcid-favicon-32x32.png" />
        </Head>
        <body>
          <Main />
          <NextScript />
        </body>
      </Html>
    );
  }
}

export default MyDocument;
