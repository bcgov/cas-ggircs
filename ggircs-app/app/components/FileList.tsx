import React, { useState } from "react";
import { Row, Col, Table } from "react-bootstrap";

const data = [
  {
    created_at: "Thu, 14 May 2020 05:25:43 GMT",
    name: "GHGBC_PROD_20120629.zip",
    size: 69.45426750183105,
  },
  {
    created_at: "Thu, 14 May 2020 05:31:32 GMT",
    name: "GHGBC_PROD_20121130.zip",
    size: 290.5470142364502,
  },
  {
    created_at: "Thu, 14 May 2020 05:31:30 GMT",
    name: "GHGBC_PROD_20121214.zip",
    size: 290.45326709747314,
  },
  {
    created_at: "Thu, 14 May 2020 05:30:22 GMT",
    name: "GHGBC_PROD_20130510.zip",
    size: 234.48462772369385,
  },
];

const FileList: React.FunctionComponent = () => {
  const [selectedFile, setSelectedFile] = useState("");

  return (
    <div>
      <Row>
        <Col md="4">
          <Table size="sm" borderless striped hover>
            <thead>
              <tr>
                <th>File</th>
                <th>Date</th>
                <th>Size</th>
              </tr>
            </thead>
            <tbody>
              {data.map((element) => (
                <tr
                  key={element.name}
                  onClick={() => setSelectedFile(element.name)}
                >
                  <td>{element.name}</td>
                  <td>{new Date(element.created_at).toDateString()}</td>
                  <td>{Math.round(element.size)}M</td>
                </tr>
              ))}
            </tbody>
          </Table>
        </Col>
        <Col md="8">
          <h4>{selectedFile}</h4>
          <p>details</p>
        </Col>
      </Row>
      <style jsx>
        {`
          td,
          th {
            font-size: 0.8em;
          }
        `}
      </style>
    </div>
  );
};

export default FileList;
